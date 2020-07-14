import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final double horizontal;
  final double vertical;
  final Function onPress;
  final String data;
  final Color btnColor;
  final Color textColor;
  const SignInButton(
      {this.horizontal,
      this.vertical,
      this.onPress,
      this.data,
      this.btnColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: RaisedButton(
        onPressed: onPress,
        color: btnColor,
        child: Text(
          data,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
