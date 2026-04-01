mixin ValidationMixin {
  // validate phone number
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!value.isValidBdPhoneRaw) {
      return 'Enter a valid BD phone number';
    }
    return null;
  }

  // validate pin
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'PIN is required';
    if (value.length < 6) return 'PIN must be 6 digits';
    return null;
  }

  // validate confirm pin matches
  String? validateConfirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) return 'Please re-enter your PIN';
    if (value != original) return 'PINs do not match';
    return null;
  }

  // validate 4 digit pin
  String? validateFourDigitPin(String? value) {
    if (value == null || value.isEmpty) {
      return 'PIN is required';
    }
    if (value.length != 4) {
      return 'PIN must be 4 digits';
    }
    return null;
  }
}

// raw validator without extension (used inside mixin)
extension _RawStringExt on String {
  bool get isValidBdPhoneRaw {
    final regex = RegExp(r'^(\+?880|0)1[3-9]\d{8}$');
    return regex.hasMatch(this);
  }
}
