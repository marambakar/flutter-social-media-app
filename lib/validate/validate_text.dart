String validateText(String value) {
  if (value.length == 0) {
    return " The value is required";
  } else {
    return null;
  }
}