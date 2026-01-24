class SecureAuthModel {
  final String? email;
  final String? pin;
  final bool? isLoading;

  const SecureAuthModel({
    this.email,
    this.pin,
    this.isLoading,
  });

  SecureAuthModel copyWith({
    String? email,
    String? pin,
    bool? isLoading,
  }) {
    return SecureAuthModel(
      email: email ?? this.email,
      pin: pin ?? this.pin,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}