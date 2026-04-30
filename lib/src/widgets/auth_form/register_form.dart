import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_shop/src/lib/cubits/auth/auth_cubit.dart';
import 'package:pet_shop/src/lib/cubits/auth/auth_state.dart';
import 'package:pet_shop/src/lib/validators/auth_form_validator.dart';
import 'package:pet_shop/src/screens/home_screen.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  final _validator = AuthFormValidator();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void handleForm() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    await context.read<AuthCubit>().register(
      name: name,
      email: email,
      password: password,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedIn) {
          Navigator.of(context).push(HomeScreen.route());
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
                    ? Center(
                        child: Text(
                          state.message,
                          style: TextStyle(fontSize: 16, color: Colors.pink),
                        ),
                      )
                    : Container(),
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text("Nama", style: TextStyle(fontSize: 16)),
                    TextFormField(
                      controller: nameController,
                      validator: _validator.nameValidator,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text("Email", style: TextStyle(fontSize: 16)),
                    TextFormField(
                      controller: emailController,
                      validator: _validator.emailValidator,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text("Password", style: TextStyle(fontSize: 16)),
                    TextFormField(
                      controller: passwordController,
                      validator: _validator.passwordValidator,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: handleForm,
                  child: Text("Daftar", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
