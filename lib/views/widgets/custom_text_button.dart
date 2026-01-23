import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String buttonText;
  final Function buttonAction;
  const CustomTextButton({super.key, required this.buttonText, required this.buttonAction});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => buttonAction(),
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.titleMedium
            ?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
