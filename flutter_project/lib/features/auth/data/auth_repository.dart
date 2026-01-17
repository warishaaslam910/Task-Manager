// import '../networking/auth_networking.dart';
// import '../../../core/storage/secure_storage.dart';
//
// class AuthRepository {
//   final AuthNetworking api;
//   final SecureStorage storage;
//
//   AuthRepository(this.api, this.storage);
//
//   Future<void> login(String username, String password) async {
//     final data = await api.login(username, password);
//     await storage.saveToken(data['token']);
//   }
//
//   Future<bool> isLoggedIn() async => await storage.getToken() != null;
//
//   Future<void> logout() async => await storage.clear();
// }


///1
import '../networking/auth_networking.dart';
import '../../../core/storage/secure_storage.dart';

class AuthRepository {
  final AuthNetworking api;
  final SecureStorage storage;

  AuthRepository(this.api, this.storage);

  // Return the token here
  Future<String> login(String username, String password) async {
    final data = await api.login(username, password);
    final token = data['accessToken'];  // ✅ Correct key
    if (token == null) throw Exception('Token not found');
    await storage.saveToken(token);
    return token; // return it
  }

  Future<bool> isLoggedIn() async => await storage.getToken() != null;

  Future<void> logout() async => await storage.clear();
}
