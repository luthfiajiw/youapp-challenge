mixin FormValidatorMixin {
  // Confirm password validation
  String? validateConfirmPassword(String? value, String? password) {
    if (value != password) {
      return 'Confirm password does not match';
    }
    return null;
  }

  // All field is required
  bool isAllFieldFilled(List<String?> fields) {
    for (String? field in fields) {
      if (field == null || field == "") return false;
    }

    return true;
  }
}