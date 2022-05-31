import 'package:flutter/material.dart';

class SquareButtonTheme {
  String theme;

  SquareButtonTheme(this.theme);

  light() => theme = 'light';
  dark() => theme = 'dark';

  String type() => theme;
}

class SquareButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final IconData? icon;
  final bool? bottom;
  final SquareButtonTheme? theme;
  final Color? labelColor;
  const SquareButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    this.icon,
    this.bottom,
    this.theme,
    this.labelColor,
  }) : super(key: key);

  EdgeInsets _getPadding(bool bottom) {
    if (bottom) {
      return const EdgeInsets.fromLTRB(24, 24, 24, 48);
    }
    return const EdgeInsets.fromLTRB(24, 24, 24, 24);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        padding: _getPadding(bottom == null ? false : bottom!),
        primary: theme != null
            ? theme!.type() == 'light'
                ? const Color.fromARGB(255, 240, 241, 245)
                : backgroundColor
            : backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon != null
              ? Icon(
                  icon,
                  color: labelColor ??
                      (theme != null
                          ? theme!.type() == 'light'
                              ? backgroundColor
                              : Colors.white
                          : Colors.white),
                  size: 24,
                )
              : const SizedBox(
                  width: 0,
                ),
          icon != null
              ? const SizedBox(
                  width: 6,
                )
              : const SizedBox(
                  width: 0,
                ),
          Text(
            label,
            style: TextStyle(
              color: labelColor ??
                  (theme != null
                      ? theme!.type() == 'light'
                          ? backgroundColor
                          : Colors.white
                      : Colors.white),
              fontFamily: 'Roboto',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
