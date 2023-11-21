import 'package:flutter/material.dart';

class LoginSecondText extends StatelessWidget {
  const LoginSecondText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Пожалуйста, введите свой адрес ниже, чтобы начать пользоваться приложением.',
      style: TextStyle(
        color: Colors.white54,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
