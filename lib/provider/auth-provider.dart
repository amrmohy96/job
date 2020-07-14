import 'package:flutter/material.dart';
import 'package:workingwithfirebase/services/auth.dart';

class AuthProvider extends InheritedWidget {
  AuthProvider({@required this.auth, this.child});
  final Auth auth;
  final Widget child;

  static Auth of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthProvider>().auth;
  }

  @override
  bool updateShouldNotify(AuthProvider oldWidget) {
    return false;
  }
}