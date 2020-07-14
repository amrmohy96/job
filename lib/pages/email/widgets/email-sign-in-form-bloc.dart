import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workingwithfirebase/Bloc/email-sign-in-bloc.dart';
import 'package:workingwithfirebase/models/email-sign-in-model.dart';

import 'package:workingwithfirebase/platform/platform-exception-alert-dialog.dart';
import 'package:workingwithfirebase/provider/auth-provider.dart';

class EmailSignInFormBloc extends StatefulWidget {
  final EmailSignInBloc bloc;
  EmailSignInFormBloc({@required this.bloc});

  static Widget create(BuildContext context) {
    final auth = AuthProvider.of(context);
    return Provider<EmailSignInBloc>(
      create: (_) => EmailSignInBloc(auth: auth),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<EmailSignInBloc>(
        builder: (context, bloc, _) => EmailSignInFormBloc(
          bloc: bloc,
        ),
      ),
    );
  }

  @override
  _EmailSignInFormBlocState createState() => _EmailSignInFormBlocState();
}

class _EmailSignInFormBlocState extends State<EmailSignInFormBloc> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  EmailSignInBloc get bloc => widget.bloc;
  FocusNode _emailNode = FocusNode();
  FocusNode _passNode = FocusNode();
  _toggle() {
    bloc.toggle();
    _email.clear();
    _password.clear();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: bloc.streamModel,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          EmailSignInModel model = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _buildChildren(context, model),
                ),
              ),
            ),
          );
        });
  }

  List<Widget> _buildChildren(BuildContext context, EmailSignInModel model) {
    return [
      TextFormField(
        focusNode: _emailNode,
        controller: _email,
        decoration: InputDecoration(
          labelText: 'email',
          hintText: 'someone@brand.com',
          enabled: model.isLoading == false,
          errorText: model.emailErr,
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        onEditingComplete: () => _onEditEmail(model),
        onChanged: (email) => bloc.updateEmail(email),
      ),
      TextFormField(
        focusNode: _passNode,
        controller: _password,
        decoration: InputDecoration(
            labelText: 'password',
            enabled: model.isLoading == false,
            errorText: model.passwordErr),
        textInputAction: TextInputAction.done,
        obscureText: true,
        onEditingComplete: _submit,
        onChanged: (password) => bloc.updatepassword(password),
      ),
      SizedBox(
        height: 10.0,
      ),
      SizedBox(
        height: 44.0,
        child: RaisedButton(
          onPressed: model.notNull ? _submit : null,
          color: Theme.of(context).primaryColor,
          child: Text(
            model.primaryText,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
      FlatButton(
        onPressed: !model.isLoading ? _toggle : null,
        child: Text(model.secondaryText),
      )
    ];
  }

  Future<void> _submit() async {
    try {
      await bloc.submit();
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'error',
        exception: e,
      ).show(context);
    }
  }

  _onEditEmail(EmailSignInModel model) {
    final focus =
        model.emailValidator.isValid(model.email) ? _passNode : _emailNode;
    FocusScope.of(context).requestFocus(focus);
  }
}
