import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  const CustomTextfield(
      {super.key,
      required this.controller,
      this.hintText,
      required this.obscureText,
      this.validator,
      this.onTap,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
        ),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}
