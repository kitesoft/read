import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:read/api/Api.dart';
import 'package:read/api/NetUtils.dart';
import 'package:read/common/DialogUtils.dart';
import 'package:read/pages/RegisterPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

//因为有很多状态的改变所以必须是StatefulWidget
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
//所填账户信息字符串
  var _str_account = '';

//所填密码信息字符串
  var _str_pass = '';

//文本编辑控制器 可用于监听文本内容的改变
  TextEditingController _controller_account = new TextEditingController();
  TextEditingController _controller_pass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//设置主题颜色
      theme: ThemeData(primaryColor: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('登录'),
          leading: IconButton(
              icon: BackButtonIcon(),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Container(
          margin: EdgeInsets.all(20.0),
          //共有6列  每一列设置自己列布局
          child: Column(
            children: <Widget>[
              //左对齐
              Align(
                alignment: Alignment.topLeft,
                child: Text('您好', style: TextStyle(fontSize: 30.0)),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text('欢迎来到登录界面', style: TextStyle(fontSize: 16.0)),
              ),

              Container(
                margin: EdgeInsets.only(top: 30.0),
                //添加controller，监听TextField内容的改变
                child: TextField(
                  controller: _controller_account,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(hintText: '请输入11位手机号码'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  controller: _controller_pass,
                  //是否以密码形式*显示
                  obscureText: true,
                  //设置hintText
                  decoration: InputDecoration(
                    hintText: '请输入6位密码',
                  ),
                ),
              ),
              //监听Text的点击事件
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10.0),
                  alignment: Alignment.topLeft,
                  child: Text(
                    '没有账号，注册一个吧~',
                    style: TextStyle(
                        //设置下划线
                        decoration: TextDecoration.underline,
                        color: Colors.blue),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40.0),
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    '登录',
                    style: TextStyle(color: Colors.white),
                  ),
                  //按钮点击事件
                  onPressed: () {
                    //获取TextField的文本内容
                    _str_account = _controller_account.text;
                    _str_pass = _controller_pass.text;
                    //登录逻辑处理
                    _LoginLocal(_str_account, _str_pass);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _LoginLocal(String account, String pass) async {
    if (account.trim() == '') {
      DialogUtils.show(context, '提示', '账号不能为空');
      return;
    }

    if (pass.trim() == '') {
      DialogUtils.show(context, '提示', '密码不能为空');
      return;
    }
    var map = {"username": account, "password": pass};
// 获取实例
    var prefs = await SharedPreferences.getInstance();
    // 获取存储数据
    var _account = prefs.getString('account') ?? "";
    var _pass = prefs.getString('pass') ?? "";

    if(account==_account&&pass==_pass){
      await prefs.setBool('islogin', true);
//      DialogUtils.show(context, '提示', '登录成功');
      Navigator.of(context).pop();
    }else{
      DialogUtils.show(context, '提示', '登录失败');
    }



  }
//  void _Login(String account, String pass) async {
//    if (account.trim() == '') {
//      DialogUtils.show(context, '提示', '账号不能为空');
//      return;
//    }
//
//    if (pass.trim() == '') {
//      DialogUtils.show(context, '提示', '密码不能为空');
//      return;
//    }
//    String url = Api.LOGIN;
//    var map = {"username": account, "password": pass};
//
//    NetUtils.post(url, params: map).then((data) {
//      if (data != null) {
//        Map<String, dynamic> map = json.decode(data);
//
//        if (map['code'] == 1000) {
//          var msg = map['data'];
//          DialogUtils.show(context, '提示', '登录成功');
//        } else {
//          DialogUtils.show(context, '提示', '登录失败');
//        }
//
//        setState(() {});
//      }
//    });
//  }
}
