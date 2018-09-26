import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:read/api/Api.dart';
import 'package:read/api/NetUtils.dart';
import 'package:read/models/Constants.dart';
import 'package:read/pages/BookDetailPage.dart';

class BookList extends StatefulWidget {
  final String bookType; //书籍类型

  BookList({Key key, this.bookType}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _NewListState(bookType);
  }
}

class _NewListState extends State<BookList> with AutomaticKeepAliveClientMixin {
  List listData = new List();
  var curPage = 1;
  var pageSize = 20;
  var listTotalSize = 0;
  bool isrun = false;
  ScrollController _controller = new ScrollController();
  String bookType;

  _NewListState(String bookType) {
    this.bookType = bookType;
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;

      if (!isrun && pixels == maxScroll && (listData.length < listTotalSize)) {
        isrun = true;
        print("NEWS_LIST: load more--------------------------$curPage-------");
        curPage++;
        getBookList(true);
      }
    });
  }

  @override
  void initState() {
    //   print("NEWS_LIST: initState");
    super.initState();
    if (listData.length > 0) {
    } else {
      getBookList(false);
    }
  }

  Future<Null> _pullToFresh() async {
    //  print("NEWS_LIST:_pullToFresh");
    curPage = 1;
    getBookList(false);

    return null;
  }

  void getBookList(bool isLoadMore) {
    String url = Api.BOOK_LIST;
    url += "&q=$bookType&page=$curPage&page_size=$pageSize";
    //  print("NEWS_LIST: $url");
    NetUtils.get(url).then((data) {
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        if (map['code'] == 0) {
          isrun = false;
          //  var msg = map['data'];
          //   listTotalSize = map['_pageinfo']['totalCount'];
          List _listdata = map['data'];
          setState(() {
            if (!isLoadMore) {
              listData.clear();
              listData = _listdata;
            } else {
              listData.addAll(_listdata);
              if (listData.length == listTotalSize) {
                // listData.add(Constants.END_LINE_TAG);
              }
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (listData.length == 0) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new RefreshIndicator(
          child: createGridView(context), onRefresh: _pullToFresh);
    }
  }

  Widget createGridView(BuildContext context) {
    var lg = listData.length;
    // print("NEWS_LIST:_NewList State:    $lg");
    return Container(
      padding: EdgeInsets.all(8.0),
      child: new GridView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          controller: _controller,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 6 / 9,
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 15.0,
              crossAxisCount: 3),
          itemCount: listData.length,
          itemBuilder: (context, i) {
            return _bookRow(i);
          }),
    );
  }

  Widget _bookRow(i) {
    var itemData = listData[i];

    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => BookDetailPage(id:itemData['id'] ,name: itemData['name'],)));
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Material(
                elevation: 8.0,
                borderRadius: BorderRadius.circular(5.0),
                shadowColor: Colors.blue.shade200,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Image(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(
                      itemData['image'],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                itemData['name'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.body2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
