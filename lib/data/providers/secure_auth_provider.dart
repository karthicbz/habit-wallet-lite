import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:habit_wallet_lite/data/constants/app_constants.dart';
import 'package:habit_wallet_lite/data/models/secure_auth_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_auth_provider.g.dart';

@riverpod
class SecureAuthNotifier extends _$SecureAuthNotifier {
  late FlutterSecureStorage _storage;

  @override
  SecureAuthModel build() {
    _storage = FlutterSecureStorage();
    return SecureAuthModel(email: null, pin: null);
  }

  Future<bool> hasAccount() async {
    return await _storage.read(key: emailKey) != null;
  }

  Future<void> saveCredentials(String email, String pin) async {
    await _storage.write(key: emailKey, value: email);
    await _storage.write(key: pinKey, value: pin);
  }

  Future<bool> validateLogin(String email, String pin) async {
    final storedEmail = await _storage.read(key: emailKey);
    final storedPin = await _storage.read(key: pinKey);

    return email == storedEmail && pin == storedPin;
  }
}
