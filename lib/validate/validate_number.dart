String validateMobile(String value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{1,12}$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return 'The value is required';
  }
  else if (!regExp.hasMatch(value)) {
    return 'Invalid mobile number';
  }
  return null;
}
String validateCode(String value) {

  if (value.length == 0 ) {
    return 'The value is required';
  }
  else if (value.length <4) {
    return 'Invalid Code number';
  }
  return null;
}