import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  const ProfileButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 24, 24, 12),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          elevation: 0,
          primary: Colors.transparent,
        ),
        child: CircleAvatar(
          backgroundColor: backgroundColor,
          child: label.isEmpty
              ? const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                )
              : Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }
}
