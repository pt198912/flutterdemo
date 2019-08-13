import 'package:flutter/material.dart';
class RowSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('RowSample'),
      ),
      body:new Container(
        //宽度
//        width: 200,
//        //高度
//        height: 200,
        // 盒子样式

        decoration: new BoxDecoration(
          color: Colors.pinkAccent,
          //设置Border属性给容器添加边框
          border: new Border.all(
            //为边框添加颜色
            color: Colors.pinkAccent,
            width: 2, //边框宽度
          ),
        ),
        child: buildRows(),
      ),
    );

  }
  Widget buildRows(){
    return new Row(
      children: <Widget>[
        new Icon(
          Icons.info,
        ),
        new Icon(
          Icons.map,
        ),
        new Icon(
          Icons.email,
        ),
      ],
    );
  }
}