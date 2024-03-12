String? usernameVaildator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }
  if (value.length < 3) {
    return 'Username must be at least 3 characters long';
  }
  if (value.length > 20) {
    return 'Username must be less than 20 characters long';
  }
  if (value.contains(' ')) {
    return 'Username must not contain spaces';
  }
  if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return 'Username must not contain special characters';
  }
  return null;
}