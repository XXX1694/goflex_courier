import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      // obscuringCharacter: '*',
      style: const TextStyle(
        color: Colors.white54,
      ),
      decoration: InputDecoration(
        labelStyle: const TextStyle(
          color: Colors.white54,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelStyle: const TextStyle(color: Colors.white54),
        suffixIcon: GestureDetector(
          onTap: () => setState(() {
            _obscureText = !_obscureText;
          }),
          child: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.white54,
          ),
        ),
        labelText: 'Пароль',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white54),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white24),
        ),
      ),

      keyboardType: TextInputType.visiblePassword,
    );
  }
}
