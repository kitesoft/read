import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:read/common/DialogUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {

  var str_account = '';//账户
  var str_pass = '';//密码
  var str_nick = '';//昵称
  File _image;//头像图片
  TextEditingController _controller_account = new TextEditingController();//账户TextEditingController
  TextEditingController _controller_pass = new TextEditingController();//密码TextEditingController
  TextEditingController _controller_nick = new TextEditingController();//昵称TextEditingController

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('注册'),
          leading: IconButton(
              icon: BackButtonIcon(),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: _body(),
      ),
    );
  }

  _Register(String account, String nick, String pass, String filepath) async {
    // 获取实例
    var prefs = await SharedPreferences.getInstance();
    // 获取存储数据
    // var count = prefs.getInt('count') ?? 0 + 1;
    // 设置存储数据
    await prefs.setString('account', account);
    await prefs.setString('pass', pass);
    await prefs.setString('nick', nick);
    await prefs.setString('userimage', filepath);
    Fluttertoast.showToast(
        msg: "注册成功！",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        bgcolor: "#e74c3c",
        textcolor: '#ffffff');
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Widget _body() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  alignment: Alignment.topLeft,
                  child: Text('您好', style: TextStyle(fontSize: 30.0)),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text('欢迎来到注册界面', style: TextStyle(fontSize: 16.0)),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              getImage();
            },
            child: Container(
              child: _image == null
                  ? CircleAvatar(
                      backgroundImage: new AssetImage('images/user.png'),
                      backgroundColor: Colors.white,
                      radius: 50.0,
                    )
                  : CircleAvatar(
                      backgroundImage: new FileImage(_image),
                      backgroundColor: Colors.white,
                      radius: 50.0,
                    ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30.0),
            child: TextField(
              controller: _controller_account,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(hintText: '请输入11位手机号码'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30.0),
            child: TextField(
              controller: _controller_nick,
              decoration: InputDecoration(hintText: '请输入您的昵称'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: TextField(
              controller: _controller_pass,
              obscureText: true,
              decoration: InputDecoration(
                hintText: '请输入6位密码',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40.0),
            child: RaisedButton(
              color: Colors.blue,
              child: Text(
                '注册',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                str_account = _controller_account.text;
                str_pass = _controller_pass.text;
                str_nick = _controller_nick.text;
                if (str_account != '' && str_pass != '' && str_nick != '') {
                  _Register(str_account, str_nick, str_pass, _image.path);
                } else {
                  DialogUtils.show(context, '提示', '请完善信息');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
