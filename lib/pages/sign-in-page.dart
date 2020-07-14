import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workingwithfirebase/Bloc/sign-in-bloc.dart';
import 'package:workingwithfirebase/pages/email/email-sign-in-page.dart';
import 'package:workingwithfirebase/platform/platform-exception-alert-dialog.dart';
import 'package:workingwithfirebase/provider/auth-provider.dart';
import 'package:workingwithfirebase/widgets/sign-in-button.dart';

class SignInPage extends StatelessWidget {
  final SignInBloc bloc;
  SignInPage({@required this.bloc});
  static Widget create(BuildContext context) {
    final auth = AuthProvider.of(context);
    return Provider<SignInBloc>(
      create: (_) => SignInBloc(auth: auth),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<SignInBloc>(
        builder: (context, bloc, _) => SignInPage(
          bloc: bloc,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
        stream: bloc.isLoadingStream,
        initialData: false,
        builder: (context, snapshot) => col(context, snapshot.data),
      ),
    );
  }

  Column col(BuildContext context, bool isloading) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          child: _buildHeader(isloading),
          height: 50.0,
        ),
        SignInButton(
          horizontal: 40.0,
          vertical: 5.0,
          data: 'Guest',
          btnColor: Colors.black,
          textColor: Colors.white,
          onPress: () => isloading ? null : _guest(context),
        ),
        SignInButton(
          horizontal: 40.0,
          vertical: 5.0,
          data: 'Email',
          btnColor: Colors.lightBlueAccent,
          textColor: Colors.white,
          onPress: () => _email(context),
        ),
      ],
    );
  }

  _guest(BuildContext context) async {
    try {
      await bloc.geust();
    } on PlatformException catch (e) {
      _showError(context, e);
    }
  }

  _showError(BuildContext context, PlatformException e) {
    PlatformExceptionAlertDialog(title: 'error', exception: e).show(context);
  }

  _email(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
  }

  _buildHeader(bool isLoading) {
    if (isLoading == true) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Text(
        'SignIn',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30.0,
        ),
      );
    }
  }
}
 