String? nameVaildator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your name';
  }
  if (value.length < 3) {
    return 'nmae must be at least 3 characters long';
  }
  if (value.length > 20) {
    return 'nmae must be less than 20 characters long';
  }
  if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return 'nmae must not contain special characters';
  }
  return null;
}