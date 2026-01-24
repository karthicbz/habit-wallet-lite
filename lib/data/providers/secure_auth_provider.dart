import 'package:flutter/services.dart';
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
    return SecureAuthModel(email: null, pin: null, isLoading: false);
  }

  Future<bool> hasAccount() async {
    return await _storage.read(key: emailKey) != null;
  }

  Future<void> saveCredentials(String email, String pin) async {
    state = state.copyWith(isLoading: true);
    try {
      await _storage.write(key: emailKey, value: email);
      await _storage.write(key: pinKey, value: pin);
    }on PlatformException catch(e){
      print(e.message);
    }
    state = state.copyWith(isLoading: false);
  }

  Future<bool> validateLogin(String email, String pin) async {
    state = state.copyWith(isLoading: true);
    final storedEmail = await _storage.read(key: emailKey);
    final storedPin = await _storage.read(key: pinKey);
    state = state.copyWith(isLoading: false);
    return email == storedEmail && pin == storedPin;
  }
}
