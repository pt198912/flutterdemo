import 'dart:convert';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ListViewPage extends StatefulWidget{
  @override
  _ListViewPageState createState() => new _ListViewPageState();

}
class _ListViewPageState extends State<StatefulWidget>{
  List widgets=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("_listviewdemo"),
      ),
      body: new ListView.builder(
        itemCount: widgets.length,
          itemBuilder: (BuildContext context,int position){
            return getRow(position);
          }
      ),
    );
  }
  Widget getRow(int i){
    return new Padding(
      padding: new EdgeInsets.all(10.0),
      child: new Text("Row ${widgets[i]["title"]}"),
    );
  }
//  loadData() async{
//    String dataUrl="https://jsonplaceholder.typicode.com/posts";
//    http.Response response=await http.get(dataUrl);
//    print("test print");
//    setState(() {
//      widgets=json.decode(response.body);
//      print(widgets);
//    });
//  }
  loadData() async{
    ReceivePort receivePort=new ReceivePort();
    await Isolate.spawn(dataLoader, receivePort.sendPort);
    SendPort sendPort=await receivePort.first;
    List msg=await sendReceive(sendPort,"https://jsonplaceholder.typicode.com/posts");
    setState(() {
      widgets=msg;
      print(widgets);
    });
  }
  static dataLoader(SendPort sendPort) async{
    ReceivePort port=new ReceivePort();
    sendPort.send(port.sendPort);
    await for(var msg in port){
      String data=msg[0];
      SendPort replyTo=msg[1];
      String dataUrl=data;
      http.Response response=await http.get(dataUrl);
      replyTo.send(json.decode(response.body));
    }
  }
  Future sendReceive(SendPort port,msg){
    ReceivePort respone=new ReceivePort();
    port.send([msg,respone.sendPort]);
    return respone.first;
  }

}