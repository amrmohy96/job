class StringValidator{
  bool isValid(String value){
    return value.isNotEmpty;
  }
}
class ValidEmailAndPassword{
  final emailValidator = StringValidator();
  final passwordValidator = StringValidator();
  final emailIsError = 'email can\'t be empty ';
  final passwordIsError = 'password can\'t be empty ';

}