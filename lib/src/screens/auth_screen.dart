import 'package:flutter/material.dart';
import 'package:pet_shop/src/widgets/auth_form/login_form.dart';
import 'package:pet_shop/src/widgets/mode_toggle.dart';
import 'package:pet_shop/src/widgets/auth_form/register_form.dart';

enum AuthType { login, register }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => AuthScreen());

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthType params = AuthType.login;

  void switchParams() {
    setState(() {
      params = params == AuthType.login ? AuthType.register : AuthType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(params == AuthType.login ? "Login" : "Register"),
            ModeToggle(),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            params == AuthType.login ? LoginForm() : RegisterForm(),
            Row(
              mainAxisAlignment: .center,
              spacing: 2,
              children: [
                Text(
                  params == AuthType.login
                      ? "Belum punya akun?"
                      : "Sudah Punya akun?",
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: switchParams,
                  child: Text(
                    params == AuthType.login ? "Daftar" : "Masuk",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
