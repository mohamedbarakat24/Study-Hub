class FormatException implements Exception {
  final String message;

  const FormatException(
      [this.message =
          'An unexpected format error occurred. Please check your input.']);

  factory FormatException.fromMessage(String message) {
    return FormatException(message);
  }
  String get formattedMessage => message;

  factory FormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const FormatException(
            'The email address format is invalid. Please enter a valid email.');
      case 'invalid-phone-number-format':
        return const FormatException(
            'The provided phone number format is invalid. Please enter a valid number.');
      case 'invalid-date-format':
        return const FormatException(
            'The date format is invalid. Please enter a valid date.');
      case 'invalid-url-format':
        return const FormatException(
            'The URL format is invalid. Please enter a valid URL.');
      case 'invalid-credit-card-format':
        return const FormatException(
            'The credit card format is invalid. Please enter a valid credit card number.');
      case 'invalid-numeric-format':
        return const FormatException(
            'The input should be a valid numeric format.');
      // Add more cases as needed...
      default:
        return const FormatException();
    }
  }
}
