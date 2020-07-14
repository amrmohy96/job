import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  final String title;
  final String content;

  const EmptyContent({
    this.title: "Nothing Here",
    this.content: "Please Add Jobs To Get Started..",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 50.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(title,
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 1.5,
                  fontSize: 30.0,
                )),
          ),
          Text(content,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
              )),
        ],
      ),
    );
  }
}
