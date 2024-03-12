String? generalVaildator(value) {
  if (value == null || value.isEmpty) {
    return 'Please fill the field';
  }
  return null;
}
