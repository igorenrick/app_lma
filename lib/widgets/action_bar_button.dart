import 'package:flutter/material.dart';

class ActionBarButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const ActionBarButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
    );
  }
}
