import 'package:flutter/material.dart';
import 'package:pet_shop/src/lib/validators/auth_form_validator.dart';

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

  void handleForm() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;
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
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: .start,
          spacing: 10,
          children: [
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
  }
}
