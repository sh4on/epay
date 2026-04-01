extension StringExtensions on String {
  // check if valid bd phone number
  bool get isValidBdPhone {
    final regex = RegExp(r'^(\+?880|0)1[3-9]\d{8}$');
    return regex.hasMatch(this);
  }

  // check if valid 4 digit pin
  bool get isValid4DigitPin {
    final regex = RegExp(r'^\d{4}$');
    return regex.hasMatch(this);
  }

  // check if valid 6 digit pin
  bool get isValid6DigitPin {
    final regex = RegExp(r'^\d{6}$');
    return regex.hasMatch(this);
  }

  // mask phone number for display
  String get maskedPhone {
    if (length < 6) return this;
    return '${substring(0, 3)}*****${substring(length - 2)}';
  }

  // format currency
  String get currencyFormat {
    return 'TK: $this';
  }
}
