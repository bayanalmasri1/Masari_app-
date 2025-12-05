import 'package:flutter/material.dart';
import '../../app_colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool outlined;
  const CustomButton({Key? key, required this.label, required this.onPressed, this.outlined = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return outlined
        ? OutlinedButton(onPressed: onPressed, child: Text(label))
        : ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.teal),
            onPressed: onPressed,
            child: Text(label),
          );
  }
}
