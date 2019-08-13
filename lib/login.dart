import 'package:flutter/material.dart';
import 'data_utils.dart';
import 'main.dart';
class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LoginPageState();
  }

}

class LoginPageState extends State<StatefulWidget>{
  GlobalKey<FormState> _signInFormKey = new GlobalKey();
  TextEditingController _userNameEditingController = new TextEditingController();
  FocusNode _emailFocusNode = new FocusNode();
  FocusScopeNode _focusScopeNode = new FocusScopeNode();
  FocusNode _passwordFocusNode = new FocusNode();
  TextEditingController _passwordEditingController = new TextEditingController();

  bool isShowPassWord = false;
  String username = '';
  String password = '';
  bool isLoading = false;


  Widget buildTextForm(){
    return new Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      width: MediaQuery.of(context).size.width*0.8,
      height: 190,
      child: new Form(
        key: _signInFormKey,
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(left: 25,right: 25,top: 20),
                  child: new TextFormField(
                    controller: _userNameEditingController,
                    focusNode: _emailFocusNode,
                    onEditingComplete: (){
                      if (_focusScopeNode == null) {
                        _focusScopeNode = FocusScope.of(context);
                      }
                      _focusScopeNode.requestFocus(_passwordFocusNode);
                    },
                    decoration: new InputDecoration(
                      icon: new Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      hintText: "email login",
                      border: InputBorder.none
                    ),
                    style: new TextStyle(color: Colors.black,fontSize: 16),
                    validator: (value){
                      if (value.isEmpty) {
                        return "登录名不可为空!";
                      }
                    },
                    onSaved: (value){
                      setState(() {
                        username=value;
                      });
                    },
                  ),
                ), 
              ),
              new Container(
                height: 1,
                width: MediaQuery.of(context).size.width*0.75,
                color: Colors.grey[400],
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left:25,right: 25,top:20),
                  child: new TextFormField(
                    controller: _passwordEditingController,
                    focusNode: _passwordFocusNode,
                    decoration: new InputDecoration(
                      icon: new Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      hintText: "login password",
                      border: InputBorder.none,
                      suffixIcon: new IconButton(
                        icon: new Icon(
                        Icons.remove_red_eye,
                        color: Colors.black,
                        ),
                        onPressed: showPassWord,
                      ),
                    ),
                    obscureText: !isShowPassWord,
                    style: new TextStyle(fontSize: 16,color: Colors.black),
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return "password is empty!";
                      }
                    },
                    onSaved: (value){
                      setState(() {
                        password=value;
                      });
                    },
                  ),
                ),
              ),
              new Container(
                height: 1,
                width: MediaQuery.of(context).size.width*0.75,
                color: Colors.grey[400],
              ),
            ],
          )
      ),
    );


  }

  Widget buildSignInButton(){
    return new GestureDetector(
      child: new Container(
        padding: EdgeInsets.only(left: 42,right: 42,top:10,bottom: 10),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Theme.of(context).primaryColor
        ),
        child: new Text(
          "Login",
          style: new TextStyle(fontSize: 25,color: Colors.white),
        ),
      ),
      onTap: (){
        if(_signInFormKey.currentState.validate()){
          doLogin();
        }
      },
    );
  }

  void doLogin(){
    //todo login logic
    _signInFormKey.currentState.save();
    setState(() {
      isLoading=true;

    });
    DataUtils.doLogin({'username':username,'password':password})
    .then((result){
      print(result);
      setState(() {
        isLoading=false;
      });
    });
    try{
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context)=>MyHomePage(title: 'page A')),
              (route)=>route==null);
    }catch(err){
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context)=>MyHomePage(title: 'page err')),
          (route)=>route==null);
    }
  }
  // 点击控制密码是否显示
  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("login"),
      ),
      body: new Column(
        children: <Widget>[
          buildTextForm(),
          buildSignInButton()
        ],
      ),
    );
  }

}