import 'package:flutter/material.dart';
import 'package:pet_shop/src/lib/validators/auth_form_validator.dart';

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

  void handleForm() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;
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
  }
}
