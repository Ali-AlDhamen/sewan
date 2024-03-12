String? numberVaildator(value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your days';
  }

  if (value.contains(RegExp(r'[a-zA-Z]')) ||
      value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return 'Please enter a valid number';
  }

  return null;
}
