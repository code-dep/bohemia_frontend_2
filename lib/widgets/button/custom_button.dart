import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, required this.text});

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              WidgetStatePropertyAll(Theme.of(context).colorScheme.onSurface),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(text,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
      ),
    );
  }
}
