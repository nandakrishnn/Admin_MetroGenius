class Validators {
  static String? validateYearsOfExperience(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your years of experience';
    }

    final numericValue = int.tryParse(value);

    if (numericValue == null) {
      return 'Please enter a valid number';
    }
    if (numericValue < 0 || numericValue > 20) {
      return 'Please enter a value between 0 and 20';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    String pattern = r'^\d{10}$';
    RegExp regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter the email';
    }
    String pattern = r'^[^@]+@[^@]+\.[^@]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }
    if (value.length > 50) {
      return 'Name must not exceed 50 characters';
    }
    return null;
  }
 static String? validateAmount(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an amount';
  }

  // Try parsing the value as a double
  final amount = double.tryParse(value);
  if (amount == null || amount <= 0) {
    return 'Please enter a valid positive amount';
  }

  // Optionally, check for a maximum amount (e.g., 10000)
  const maxAmount = 10000.0;
  if (amount > maxAmount) {
    return 'Amount should not exceed $maxAmount';
  }

  return null; // No errors
}
static String? validateDescription(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a description';
  }

  final minLength = 10; // Minimum length for the description
  final maxLength = 500; // Maximum length for the description

  if (value.length < minLength) {
    return 'Description must be at least $minLength characters long';
  }

  if (value.length > maxLength) {
    return 'Description must not exceed $maxLength characters';
  }

  return null; // No errors
}

}
