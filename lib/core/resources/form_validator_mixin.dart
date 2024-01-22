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

  // Validate email
  String? isEmailValid(String? email) {
    final emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    
    if (emailRegExp.hasMatch(email ?? "")) {
      return null;
    }

    return "Email is invalid";
  }
}