import 'dart:io';

import 'package:flutter/material.dart';
import 'package:read/pages/LoginPage.dart';
import 'package:read/pages/SettingPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyInfoPageState();
  }
}

class MyInfoPageState extends State<MyInfoPage> {

  String _nick = "登录/注册";
  String _str_des = '点击登录查看更多信息';
  File _image;
  bool _isLogin = false;
  @override
  void initState() {
    super.initState();

    _GetUser();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
      child: Container(
        child: Column(
          children: <Widget>[
            _LoginTop(),
            _CardView(),
            _ColumnsBook(),
            Container(
              height: 5.0,
              color: const Color(0x559DA0A5),
            ),
            _Setting(),
            Container(
              height: 0.5,
              color: const Color(0x559DA0A5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _LoginTop() {
    return GestureDetector(
      onTap: () {
        if (!_isLogin) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LoginPage()))
              .then((str) {
            setState(() {
              _GetUser();
            });
          });
        }
      },
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 5.0),
            child: (_isLogin == false || _image == null)
                ? CircleAvatar(
                    backgroundImage: new AssetImage('images/user.png'),
                    backgroundColor: Colors.white,
                    radius: 40.0,
                  )
                : CircleAvatar(
                    backgroundImage: new FileImage(_image),
                    backgroundColor: Colors.white,
                    radius: 40.0,
                  ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 5.0),
                  child: Text(_nick,
                      style: TextStyle(
                        fontSize: 20.0,
                      )),
                  alignment: Alignment.topLeft,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 5.0),
                  child: Text(_str_des,
                      style: TextStyle(
                        fontSize: 12.0,
                      )),
                  alignment: Alignment.topLeft,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _CardView() {
    return Container(
      margin: EdgeInsets.fromLTRB(17.0, 10.0, 17.0, 0.0),
      child: Card(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 5.0),
                    child: Text(
                      '强力推荐卡',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 15.0),
                    child: Text(
                      '最给力的书单就在这里',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.yellow,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 5.0),
              child: Text(
                '立即领取',
                style: TextStyle(fontSize: 12.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _ColumnsBook() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                child: Text(
                  '0',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                child: Text(
                  '我想要的书籍',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                child: Text(
                  '0',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                child: Text(
                  '我收藏的书籍',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                child: Text(
                  '0',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                child: Text(
                  '我点赞的书籍',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _Setting() {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SettingPage()))
              .then((str) {
            setState(() {
              _GetUser();
            });
          });
        },
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20.0),
              child: Image.asset(
                'images/setting.png',
                width: 20.0,
                height: 20.0,
              ),
            ),
            Expanded(
              child: Text('设置'),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: Image.asset(
                'images/ic_arrow_right.png',
                width: 20.0,
                height: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _GetUser() async {
// 获取实例
    var prefs = await SharedPreferences.getInstance();
    // 获取存储数据

    _isLogin = prefs.getBool('islogin') ?? false;
    _nick = _isLogin ? prefs.getString('nick') ?? "登录/注册" : "登录/注册";
    String _userpath = prefs.getString('userimage') ?? "";
    if (_isLogin) {
      _str_des = 'hello flutter';
      if (_userpath != '') {
        _image = new File(_userpath);
      }
    } else {
      _str_des = '点击登录查看更多信息';
    }
    setState(() {});
  }
}
