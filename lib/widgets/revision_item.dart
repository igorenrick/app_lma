import 'package:flutter/material.dart';

class RevisionItem extends StatelessWidget {
  final String label;
  final String value;
  const RevisionItem({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 24, top: 12, right: 24, bottom: 6),
          child: Text(
            label,
            style: const TextStyle(
              color: Color.fromARGB(255, 142, 142, 147),
              fontFamily: 'Roboto',
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 12),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
