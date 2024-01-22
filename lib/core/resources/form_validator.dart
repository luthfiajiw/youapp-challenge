mixin FormValidator {
  // Confirm password validation
  String? validateConfirmPassword(String? value, String password) {
    if (value != password) {
      return 'Confirm password does not match';
    }
    return null;
  }
}