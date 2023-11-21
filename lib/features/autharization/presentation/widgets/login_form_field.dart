import 'package:flutter/material.dart';
import 'package:goflex_courier/features/autharization/presentation/widgets/password_field.dart';
import 'package:goflex_courier/features/autharization/presentation/widgets/phone_field.dart';

class LoginFormField extends StatelessWidget {
  const LoginFormField({
    super.key,
    required this.passwordController,
    required this.phoneController,
  });
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PhoneField(controller: phoneController),
        const SizedBox(height: 20),
        PasswordField(controller: passwordController),
      ],
    );
  }
}
