import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final Function? buttonAction;

  const CustomElevatedButton({
    super.key,
    required this.buttonText,
    this.buttonAction,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => (buttonAction != null) ? buttonAction?.call() : () {},
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 16)),
        backgroundColor: WidgetStatePropertyAll(
          Theme.of(context).colorScheme.primary,
        ),
      ),
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
