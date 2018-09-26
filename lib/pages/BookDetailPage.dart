import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:read/api/Api.dart';
import 'package:read/api/NetUtils.dart';
import 'package:read/widgets/CommentBar.dart';

class BookDetailPage extends StatefulWidget {
  final String id;
  final String name;

  const BookDetailPage({Key key, this.id, this.name}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _BookDetailPageState(id);
  }
}

class _BookDetailPageState extends State<BookDetailPage> {
  String id = "";

  _BookDetailPageState(this.id);

  String name = "";
  String image = "";
  String introduce = "";

  @override
  void initState() {
    super.initState();
    getBookDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 50.0),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20.0),
                    height: 200.0,
                    alignment: Alignment.center,
                    child: Image.network(
                      image,
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                    child: Divider(
                      height: 2.0,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "收藏",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          margin: EdgeInsets.only(right: 10.0),
                        ),
                        Container(
                            margin: EdgeInsets.only(right: 20.0),
                            child: Image.asset("images/my_default.png",
                                width: 20.0, height: 20.0))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0,),
                    height: 20.0,
                    color: Colors.black12,
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: Text(introduce,style: TextStyle(fontSize: 20.0),),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: CommentBar(),
            )
          ],
        ),
      ),
    );
  }

  void getBookDetail() {
    String url = Api.BOOK_DETAIL + id;
    NetUtils.get(url).then((data) {
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        if (map['code'] == 0) {
          name = map['data']['name'];
          image = map['data']['image'];
          introduce = map['data']['introduce'];
          setState(() {});
        }
      }
    });
  }
}

//Widget getCommetList() {
//
//}
