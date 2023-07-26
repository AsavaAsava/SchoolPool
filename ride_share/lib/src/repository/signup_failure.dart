class SignUpMailPasswordFailure {
  final String message;

  const SignUpMailPasswordFailure([this.message = "An Unkown error occurred"]);

  factory SignUpMailPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const SignUpMailPasswordFailure(
            'Please enter a stronger password.');

      case 'invalid-email':
        return const SignUpMailPasswordFailure(
            'Email is invalid or badly formatted.');

      case 'email-already-in-use':
        return const SignUpMailPasswordFailure(
            'An account already exists for that email.');

      case 'operation-not-allowed':
        return const SignUpMailPasswordFailure(
            'This operation is not allowed.');

      case 'user-disabled':
        return const SignUpMailPasswordFailure(
            'This user has been disabled. Please contact support for help.');

      default:
        return const SignUpMailPasswordFailure();
    }
  }
}