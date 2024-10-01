class MyExceptions implements Exception {
  final String message;

  const MyExceptions(
      [this.message = 'An unexpected error occurred. Please try again.']);
  factory MyExceptions.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const MyExceptions(
            'The email address is already registered. Please use a different email.');
      case 'invalid-email':
        return const MyExceptions(
            'The email address provided is invalid. Please enter a valid email.');
      case 'weak-password':
        return const MyExceptions(
            'The password is too weak. Please choose a stronger password.');
      case 'user-disabled':
        return const MyExceptions(
            'This user account has been disabled. Please contact support for assistance.');
      case 'user-not-found':
        return const MyExceptions('Invalid login details. User not found.');
      case 'wrong-password':
        return const MyExceptions(
            'Incorrect password. Please check your password and try again.');
      case 'INVALID_LOGIN_CREDENTIALS':
        return const MyExceptions(
            'Invalid login credentials. Please double-check your information.');
      case 'too-many-requests':
        return const MyExceptions('Too many requests. Please try again later.');
      case 'invalid-argument':
        return const MyExceptions(
            'Invalid argument provided to the authentication method.');
      case 'invalid-password':
        return const MyExceptions('Incorrect password. Please try again.');
      case 'invalid-phone-number':
        return const MyExceptions('The provided phone number is invalid.');
      case 'operation-not-allowed':
        return const MyExceptions(
            'The sign-in provider is disabled for your Firebase project.');
      case 'session-cookie-expired':
        return const MyExceptions(
            'The Firebase session cookie has expired. Please sign in again.');
      case 'uid-already-exists':
        return const MyExceptions(
            'The provided user ID is already in use by another user.');
      case 'sign_in_failed':
        return const MyExceptions('Sign-in failed. Please try again.');
      case 'network-request-failed':
        return const MyExceptions(
            'Network request failed. Please check your internet connection.');
      case 'internal-error':
        return const MyExceptions('Internal error. Please try again later.');
      case 'invalid-verification-code':
        return const MyExceptions(
            'Invalid verification code. Please enter a valid code.');
      case 'invalid-verification-id':
        return const MyExceptions(
            'Invalid verification ID. Please request a new verification code.');
      case 'quota-exceeded':
        return const MyExceptions('Quota exceeded. Please try again later.');
      default:
        return const MyExceptions();
    }
  }
}
