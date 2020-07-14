import 'package:workingwithfirebase/pages/email/utils/string-validator.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInModel with ValidEmailAndPassword {
  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool isSubmitted;

  EmailSignInModel({
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.isSubmitted = false,
  });

  EmailSignInModel copyWith(
      {String email,
      String password,
      EmailSignInFormType formType,
      bool isLoading,
      bool isSubmitted}) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }
  // bool get notNull => this.emailValidator.isValid(this.email) &&
  //   this.passwordValidator.isValid(this.password) &&
  //   !this.isLoading;

  bool get notNull =>
      emailValidator.isValid(email) &&
      passwordValidator.isValid(password) &&
      !isLoading;

  String get emailErr {
    bool emailError = isSubmitted && !emailValidator.isValid(this.email);
    return emailError ? emailIsError : null;
  }

  String get passwordErr {
    bool passError = isSubmitted && !passwordValidator.isValid(this.password);
    return passError ? passwordIsError : null;
  }

  String get secondaryText => this.formType == EmailSignInFormType.signIn
      ? 'Need Account ,Register'
      : 'have one, login';
  String get primaryText =>
      this.formType == EmailSignInFormType.signIn ? 'SignIn' : 'Create one';
}
