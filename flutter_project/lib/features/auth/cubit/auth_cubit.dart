
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repo;
  AuthCubit(this.repo) : super(AuthInitial());

  Future<void> login(String username, String password) async {
    emit(AuthLoading());
    try {
      final token = await repo.login(username, password);
      emit(AuthLoggedIn(token)); // emit with token
      print('AuthLoggedIn emitted with token: $token');
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    await repo.logout();
    emit(AuthInitial());
  }
}
