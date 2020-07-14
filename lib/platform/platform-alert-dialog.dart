import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workingwithfirebase/platform/platform-widget.dart';

class PlatformAlertDialog extends PlatformWidget {
  final String title;
  final String content;
  final String actionText;
  final String cancel;
  PlatformAlertDialog(
      {@required this.title, @required this.content, @required this.actionText,this.cancel})
      : assert(title != null),
        assert(content != null),
        assert(actionText != null);

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS ?
        await showCupertinoDialog<bool>(context: context, builder: (context) => this )
        : await showDialog<bool>(context: context, builder: (context) => this);
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: listOfActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: listOfActions(context),
    );
  }

  List<Widget> listOfActions(BuildContext context) {
    final actions = <Widget>[];
    if(cancel != null){
      actions.add(
        FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancel),
        ),
      );
    }
    actions.add(
      FlatButton(
        onPressed: () => Navigator.of(context).pop(true),
        child: Text(actionText),
      ),
    );
    return actions;
  }
}
