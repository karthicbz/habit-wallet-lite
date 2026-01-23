class SecureAuthModel {
  final String? email;
  final String? pin;

  SecureAuthModel copyWith({
    String? email,
    String? pin,
  }) {
    return SecureAuthModel(
      email: email ?? this.email,
      pin: pin ?? this.pin,
    );
  }

  const SecureAuthModel({
    required this.email,
    required this.pin,
  });
}