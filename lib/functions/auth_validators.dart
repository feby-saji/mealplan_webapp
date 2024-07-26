String? validateName(String? value) {
  final RegExp regExp = RegExp(r'\d');

  if (value == null || value.isEmpty) {
    return 'Name cannot be empty';
  }
  if (regExp.hasMatch(value)) {
    return 'cannot contain numbers';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  return null;
}
