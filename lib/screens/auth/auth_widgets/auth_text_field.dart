import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final IconData icon;
  final bool obscure;
  final Widget? suffixIcon;
  final VoidCallback onTap;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.label,
    required this.icon,
    this.obscure = false,
    this.suffixIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool focused = focusNode.hasFocus;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: focused ? const Color(0xFF00897B) : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscure,
        style: TextStyle(
          color: focused ? Colors.white : Colors.black87,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: focused ? Colors.white : Colors.grey,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(
            icon,
            color: focused ? Colors.white : Colors.grey,
          ),
          suffixIcon: suffixIcon,
        ),
        onTap: onTap,
      ),
    );
  }
}
