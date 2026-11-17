import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionManager {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String sessionKey = 'session_id';
  static const String usernameKey = 'username';
  static const String vehicleNumberKey = 'vehicle_number';
  static const String authTokenKey = 'auth_token';
  static const String expiryKey = 'session_expiry';

  // Save session for 24 hours
  static Future<void> saveSession(
    String session, {
    required String username,
    String vehicleNumber = '',
    String authToken = '',
  }) async {
    final expiry = DateTime.now().toUtc().add(const Duration(hours: 24));

    await _storage.write(key: sessionKey, value: session);
    await _storage.write(key: usernameKey, value: username);
    await _storage.write(key: vehicleNumberKey, value: vehicleNumber);
    await _storage.write(key: authTokenKey, value: authToken);
    await _storage.write(key: expiryKey, value: expiry.toIso8601String());
  }

  // Check session validity
  static Future<bool> isSessionValid() async {
    final session = await _storage.read(key: sessionKey);
    final expiryString = await _storage.read(key: expiryKey);

    if (session == null || session.isEmpty || expiryString == null) {
      return false;
    }

    try {
      final expiry = DateTime.parse(expiryString);

      if (!DateTime.now().toUtc().isBefore(expiry)) {
        await clearSession();
        return false;
      }

      return true;
    } catch (_) {
      await clearSession();
      return false;
    }
  }

  // Get saved session
  static Future<String?> getSession() async {
    return _storage.read(key: sessionKey);
  }

  // Get saved username
  static Future<String> getUsername() async {
    return (await _storage.read(key: usernameKey)) ?? '';
  }

  // Get saved vehicle number
  static Future<String> getVehicleNumber() async {
    return (await _storage.read(key: vehicleNumberKey)) ?? '';
  }

  // Get saved authentication token
  static Future<String?> getAuthToken() async {
    return _storage.read(key: authTokenKey);
  }

  // Clear login session
  static Future<void> clearSession() async {
    await _storage.delete(key: sessionKey);
    await _storage.delete(key: usernameKey);
    await _storage.delete(key: vehicleNumberKey);
    await _storage.delete(key: authTokenKey);
    await _storage.delete(key: expiryKey);
  }
}
