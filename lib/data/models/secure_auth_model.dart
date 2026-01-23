class SecureAuthModel {
  final String email;
  final String pin;

  const SecureAuthModel({
    required this.email,
    required this.pin,
  });

  SecureAuthModel copyWith({
    String? email,
    String? pin,
  }) {
    return SecureAuthModel(
      email: email ?? this.email,
      pin: pin ?? this.pin,
    );
  }
}