import 'package:flutter/material.dart';
import 'package:goflex_courier/common/colors.dart';

class LoginMainText extends StatelessWidget {
  const LoginMainText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: 'Добро пожаловать в gofl',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 28,
            ),
          ),
          TextSpan(
            text: 'ex',
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.w700,
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }
}
