import 'dart:async';

import 'package:workingwithfirebase/models/email-sign-in-model.dart';
import 'package:workingwithfirebase/services/auth.dart';

class EmailSignInBloc {
  final Auth auth;
  // stream controller
  final StreamController<EmailSignInModel> _controller =
      StreamController<EmailSignInModel>();

  EmailSignInBloc({this.auth});

  // input for stream builder
  Stream<EmailSignInModel> get streamModel => _controller.stream;

  // keep track of the model
  EmailSignInModel _model = EmailSignInModel();

  //  update the model
  // add to controller

  updateWith(
      {String email,
      String password,
      EmailSignInFormType formType,
      bool isLoading,
      bool isSubmitted}) {
    _model = _model.copyWith(
      email: email,
      password: password,
      formType: formType,
      isLoading: isLoading,
      isSubmitted: isSubmitted,
    );
    _controller.add(_model);
  }

  updateEmail(String email) => updateWith(email: email);
  updatepassword(String password) => updateWith(password: password);

  Future<void> submit() async {
    updateWith(isLoading: true, isSubmitted: true);
    try {
      await Future.delayed(Duration(seconds: 3));
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createUserWithEmailAndPassword(
            _model.email, _model.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void toggle() {
    final formtype = _model.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
        email: '',
        password: '',
        isSubmitted: false,
        isLoading: false,
        formType: formtype);
  }

  void dispose() {
    _controller.close();
  }
}
