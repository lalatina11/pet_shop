import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_shop/src/lib/cubits/auth/auth_cubit.dart';
import 'package:pet_shop/src/lib/cubits/auth/auth_state.dart';
import 'package:pet_shop/src/lib/validators/auth_form_validator.dart';
import 'package:pet_shop/src/screens/home_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final formValidator = AuthFormValidator();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void handleForm() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    final email = emailController.text;
    final password = passwordController.text;
    await context.read<AuthCubit>().login(email: email, password: password);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedIn) {
          Navigator.of(context).push(HomeScreen.route(index: 0));
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: .start,
              spacing: 10,
              children: [
                state is AuthError
                    ? Text(
                        state.message,
                        style: TextStyle(fontSize: 16, color: Colors.pink),
                      )
                    : Container(),
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text("Email", style: TextStyle(fontSize: 16)),
                    TextFormField(
                      controller: emailController,
                      validator: formValidator.emailValidator,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text("Password", style: TextStyle(fontSize: 16)),
                    TextFormField(
                      controller: passwordController,
                      validator: formValidator.passwordValidator,
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(.infinity, 50),
                  ),
                  onPressed: handleForm,
                  child: Text(
                    "Masuk",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
