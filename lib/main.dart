import 'package:flutter/material.dart';
import 'package:workingwithfirebase/pages/landing-page.dart';
import 'package:workingwithfirebase/provider/auth-provider.dart';
import 'package:workingwithfirebase/services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.lightBlueAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LandingPage(),
      ),
    );
  }
}
