import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workingwithfirebase/models/email-sign-in-model.dart';
import 'package:workingwithfirebase/pages/email/utils/string-validator.dart';
import 'package:workingwithfirebase/platform/platform-exception-alert-dialog.dart';
import 'package:workingwithfirebase/provider/auth-provider.dart';


class EmailSignInForm extends StatefulWidget with ValidEmailAndPassword {

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  String get emailText => _email.text;

  String get passText => _password.text;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  FocusNode _emailNode = FocusNode();
  FocusNode _passNode = FocusNode();

  bool _isSubmitted = false;
  bool isLoading = false;

  _toggle() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildChildren(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildChildren(BuildContext context) {
//    final notNull = passText.isNotEmpty && emailText.isNotEmpty;
    final notNull = widget.emailValidator.isValid(emailText) &&
        widget.passwordValidator.isValid(passText) &&
        !isLoading;
    final emailValid =
        _isSubmitted && !widget.emailValidator.isValid(emailText);
    final passwordValid =
        _isSubmitted && !widget.passwordValidator.isValid(passText);
    final primaryText =
        _formType == EmailSignInFormType.signIn ? 'SignIn' : 'Create one';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need Account ,Register'
        : 'have one, login';
    return [
      TextFormField(
        focusNode: _emailNode,
        controller: _email,
        decoration: InputDecoration(
          labelText: 'email',
          hintText: 'someone@brand.com',
          enabled: isLoading == false,
          errorText: emailValid ? widget.emailIsError : null,
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        onEditingComplete: _onEditEmail,
        onChanged: (email) => updateFormState(),
      ),
      TextFormField(
        focusNode: _passNode,
        controller: _password,
        decoration: InputDecoration(
            labelText: 'password',
            enabled: isLoading == false,
            errorText: passwordValid ? widget.passwordIsError : null),
        textInputAction: TextInputAction.done,
        obscureText: true,
        onEditingComplete: _submit,
        onChanged: (password) => updateFormState(),
      ),
      SizedBox(
        height: 10.0,
      ),
      SizedBox(
        height: 44.0,
        child: RaisedButton(
          onPressed: notNull ? _submit : null,
          color: Theme.of(context).primaryColor,
          child: Text(
            primaryText,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
      FlatButton(
        onPressed: !isLoading ? _toggle : null,
        child: Text(secondaryText),
      )
    ];
  }

  _submit() async {
    setState(() {
      _isSubmitted = true;
      isLoading = true;
    });
    try {
      final auth = AuthProvider.of(context);
      await Future.delayed(Duration(seconds: 3));
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(emailText, passText);
      } else {
        await auth.createUserWithEmailAndPassword(emailText, passText);
      }
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(title: 'error', exception: e,).show(context);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _onEditEmail() {
    final focus =
        widget.emailValidator.isValid(emailText) ? _passNode : _emailNode;
    FocusScope.of(context).requestFocus(focus);
  }

  updateFormState() {
    setState(() {});
  }
}
