import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
 abstract class PlatformWidget extends StatelessWidget {
   Widget buildCupertinoWidget(BuildContext context);
   Widget buildMaterialWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS){
      return buildCupertinoWidget(context);
    }else{
      return buildMaterialWidget(context);
    }
  }
}
