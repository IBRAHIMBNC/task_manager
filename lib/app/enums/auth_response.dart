enum AuthResponse {
  success,
  invalidCredentials,
  unKnown;

  String get message {
    switch (this) {
      case AuthResponse.success:
        return 'User logged in successfully';
      case AuthResponse.invalidCredentials:
        return 'Invalid credentials';

      case AuthResponse.unKnown:
        return 'Unknown error';
      default:
        return '';
    }
  }

  // static AuthResponse fromString(String value) {
  //   switch (value) {
  //     case 'success':
  //       return AuthResponse.success;
  //     case 'invalidCredentials':
  //       return AuthResponse.invalidCredentials;
  //     default:
  //       return AuthResponse.unKnown;
  //   }
  // }
}
