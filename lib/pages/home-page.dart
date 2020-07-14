import 'package:flutter/material.dart';
import 'package:workingwithfirebase/platform/platform-alert-dialog.dart';
import 'package:workingwithfirebase/provider/auth-provider.dart';

class HomePage extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page', style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () => confirmSignOut(context),
              icon: Icon(Icons.close, color: Colors.white),
              label: Text('signout', style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }

  Future<void> confirmSignOut(BuildContext context) async {
    final auth = AuthProvider.of(context);
    final sign = await PlatformAlertDialog(
            title: 'sign-out', content: 'Are you sure ?', actionText: 'ok',cancel: 'cancel',)
        .show(context);
    if(sign == true){
     await auth.signOut();
    }
    }
  }
