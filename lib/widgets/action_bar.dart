import 'package:app_lma/widgets/action_bar_button.dart';
import 'package:flutter/material.dart';

class ActionBar extends StatelessWidget {
  final List<ActionBarButton> actions;
  final Color? backgroundColor;
  const ActionBar({
    Key? key,
    required this.actions,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      width: MediaQuery.of(context).size.width,
      color: backgroundColor ?? const Color.fromARGB(255, 126, 205, 201),
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actions.length,
        itemBuilder: (context, index) {
          return actions[index];
        },
      ),
    );
  }
}
