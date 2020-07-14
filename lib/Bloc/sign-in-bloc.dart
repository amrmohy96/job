import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:workingwithfirebase/models/user.dart';
import 'package:workingwithfirebase/services/auth.dart';

class SignInBloc {
  final Auth auth;
  final StreamController<bool> _isLoadingController = StreamController<bool>();
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  SignInBloc({@required this.auth});

  void _setIsLoading(bool isloading) {
    _isLoadingController.add(isloading);
  }

  void dispose() {
    _isLoadingController.close();
  }

  Future<User> geust() async {
    try {
      _setIsLoading(true);
      return await auth.guestUser();
    } catch (e) {
      _setIsLoading(false);
      rethrow;
    } 
  }
}
