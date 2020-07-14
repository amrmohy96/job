import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workingwithfirebase/platform/platform-widget.dart';

class PlatformAlertDialogAction extends PlatformWidget {
  final Widget child;
  final Function onPress;

  PlatformAlertDialogAction({this.child, this.onPress});

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPress,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return FlatButton(
      onPressed: onPress,
      child: child,
    );
  }
}
