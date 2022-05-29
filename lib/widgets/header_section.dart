import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  const HeaderSection({
    Key? key,
    required this.title,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height / 3) - 56,
      width: MediaQuery.of(context).size.width,
      color: backgroundColor ?? const Color.fromARGB(255, 126, 205, 201),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto',
          fontSize: 28,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
