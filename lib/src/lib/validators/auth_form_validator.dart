import 'package:email_validator/email_validator.dart';

class AuthFormValidator {
  String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return "Harap masukkan email";
    }
    final isValidEmail = EmailValidator.validate(email);
    if (!isValidEmail) {
      return "Harap masukkan email yang valid!";
    }
    return null;
  }

  String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return "Harap masukkan password";
    }

    if (password.length < 8) {
      return "Harap masukkan password min 8 karakter";
    }
    if (password.length > 32) {
      return "Password tidak boleh melebihi 32 karakter";
    }

    return null;
  }

  String? nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return "Harap masukkan Nama";
    }

    if (name.length < 8) {
      return "Harap masukkan Nama min 8 karakter";
    }
    if (name.length > 128) {
      return "Nama tidak boleh melebihi 128 karakter";
    }

    return null;
  }
}
