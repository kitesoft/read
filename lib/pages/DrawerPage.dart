import 'dart:io';

import 'package:flutter/material.dart';
import 'package:read/pages/MyInfoPage.dart';
import 'package:read/pages/SettingPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DrawerPageState();
  }
}

class _DrawerPageState extends State<DrawerPage> {
  static const double IMAGE_ICON_WIDTH = 30.0;
  static const double IRROW_ICON_WIDTH = 16.0;

  File _image;
  bool _isLogin = false;
  String _nick;

  var rightArrowIcon = new Image.asset(
    "images/ic_arrow_right.png",
    width: IRROW_ICON_WIDTH,
    height: IRROW_ICON_WIDTH,
  );

  List menuTitles = ["设置"];
  List menuIcons = [
    './images/setting.png',
  ];

  TextStyle menuStyle = new TextStyle(fontSize: 15.0);

  @override
  void initState() {
    super.initState();
    _GetUser();
  }

  @override
  Widget build(BuildContext context) {
    return new ConstrainedBox(
      constraints: const BoxConstraints.expand(width: 304.0),
      child: new Material(
        elevation: 16.0,
        child: new Container(
          decoration: new BoxDecoration(color: Colors.white),
          child: new ListView.builder(
              itemCount: menuTitles.length * 2 + 1, itemBuilder: renderRow),
        ),
      ),
    );
  }

  Widget getIconImage(path) {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 6.0),
      child: new Image.asset(
        path,
        width: 28.0,
        height: 28.0,
      ),
    );
  }

  Widget renderRow(BuildContext context, int index) {
    if (index == 0) {
      return Container(
          padding: EdgeInsets.only(top: 30.0),
          width: 304.0,
          height: 300.0,
          decoration: BoxDecoration(
            image: new DecorationImage(
                image: ExactAssetImage("./images/bg.png"), fit: BoxFit.fill),
          ),
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              Stack(
                alignment: const Alignment(1.0, 0.6),
                children: [
                  (_isLogin == false && _image == null)
                      ? CircleAvatar(
                    backgroundColor: Colors.grey,

                          radius: 40.0,
                        )
                      : CircleAvatar(
                          backgroundImage: new FileImage(_image),
                          backgroundColor: Colors.white,
                          radius: 40.0,
                        ),
                  new Container(
                    child: (_isLogin == false)
                        ? new Text(
                            '未登录',
                            style: new TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )
                        : new Text(
                            _nick,
                            style: new TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                            ),
                          ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
                child: Text(
                  "送个程序员的爱心书单",
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
              )
            ],
          ));
    }
    index -= 1;
    if (index.isOdd) {
      return new Divider();
    }
    index = index ~/ 2;
    var listItemContent = new Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
      child: new Row(
        children: <Widget>[
          getIconImage(menuIcons[index]),
          new Expanded(
              child: new Text(
            menuTitles[index],
            style: menuStyle,
          )),
          rightArrowIcon
        ],
      ),
    );

    return new InkWell(
      child: listItemContent,
      onTap: () {
        switch (index) {
          case 0:
            Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
              return new SettingPage();
            }));
        }
      },
    );
  }

  void _GetUser() async {
// 获取实例
    var prefs = await SharedPreferences.getInstance();
    // 获取存储数据

    _isLogin = prefs.getBool('islogin') ?? false;
    _nick = _isLogin ? prefs.getString('nick') ?? "未登录" : "未登录";
    String _userpath = prefs.getString('userimage') ?? "";
    if (_isLogin) {
      if (_userpath != '') {
        _image = new File(_userpath);
      }
    }
    setState(() {});
  }
}
