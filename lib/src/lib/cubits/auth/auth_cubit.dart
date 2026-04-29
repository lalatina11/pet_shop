import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_shop/src/lib/cubits/auth/auth_state.dart';
import 'package:pet_shop/src/lib/repository/auth_remote_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  SharedPreferences sharedPreferences;
  final authRemote = AuthRemoteRepository();

  AuthCubit({required this.sharedPreferences}) : super(AuthInitial());

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
