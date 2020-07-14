import 'package:flutter/material.dart';
import 'package:workingwithfirebase/pages/email/widgets/email-sign-in-form-bloc.dart';


class EmailSignInPage extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          'Sign-In',
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
              fontSize: 18.0),
        ),
      ),
      body: EmailSignInFormBloc.create(context),
    );
  }
}
