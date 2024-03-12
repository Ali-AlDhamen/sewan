String handleAuthException(String code) {
  return switch (code) {
    'email-already-in-use' => 'Email already used. Go to login page.',
    'user-not-found' => 'No user found with this email.',
    'invalid-email' => 'Email address is invalid.',
    'operation-not-allowed' => 'Server error, please try again later.',
    'too-many-requests' => 'Too many requests to log into this account.',
    'weak-password' => 'Password should be at least 6 characters.',
    'user-disabled' => 'User disabled.',
    'wrong-password' => 'Wrong email/password combination.',
    _ => 'Login failed. Please try again.',
  };
}
