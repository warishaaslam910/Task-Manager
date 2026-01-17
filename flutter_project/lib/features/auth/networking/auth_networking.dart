import '../../../core/networking/api_networking.dart';

class AuthNetworking {
  final ApiNetworking networking;
  AuthNetworking(this.networking);

  Future<Map<String, dynamic>> login(String username, String password) async {
    final res = await networking.post('/auth/login', data: {
      'username': username,
      'password': password,
    });
    return res.data;
  }
}
