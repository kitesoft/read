import 'package:flutter/material.dart';

class CommentBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              style: TextStyle(height: 0.8, color: Colors.black),
              decoration: InputDecoration(
                hintText: "在此发表评论",
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          RaisedButton(
            onPressed: () {},
            color: Colors.blue,
            child: Text(
              "评论",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
