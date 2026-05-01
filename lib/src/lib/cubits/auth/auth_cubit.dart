import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_shop/src/lib/cubits/auth/auth_state.dart';
import 'package:pet_shop/src/lib/repository/auth_remote_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  SharedPreferences sharedPreferences;
  final authRemote = AuthRemoteRepository();

  AuthCubit({required this.sharedPreferences}) : super(AuthInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final res = await authRemote.register(
        name: name,
        email: email,
        password: password,
      );
      if (!res.success || res.data == null || res.data.toString().isEmpty) {
        return emit(AuthError(message: res.message));
      }
      sharedPreferences.setString("token", res.data);
      emit(AuthLoggedIn());
    } catch (e) {
      emit(AuthError(message: "Unexpexted error"));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final res = await authRemote.login(email: email, password: password);
      if (!res.success || res.data == null || res.data.toString().isEmpty) {
        return emit(AuthError(message: res.message));
      }
      sharedPreferences.setString("token", res.data);
      emit(AuthLoggedIn());
    } catch (e) {
      emit(AuthError(message: "Unexpexted error"));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      final token = sharedPreferences.getString("token") ?? "";
      await authRemote.logout(token: token);
      sharedPreferences.setString("token", "");
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(message: "Unexpexted error"));
    }
  }

  Future<void> checkIsLoggedIn() async {
    emit(AuthLoading());
    try {
      final token = sharedPreferences.getString("token");
      if (token == null || token.isEmpty) {
        return emit(AuthInitial());
      }
      final success = await authRemote.checkIsLoggedIn(token: token);
      if (!success) {
        return emit(AuthInitial());
      }
      emit(AuthLoggedIn());
    } catch (e) {
      print(e);
      emit(AuthInitial());
    }
  }
}
