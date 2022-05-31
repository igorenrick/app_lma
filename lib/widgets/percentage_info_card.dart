import 'package:flutter/material.dart';

class MaterialPercentageInfoCard extends StatelessWidget {
  final double initialAmount;
  final double currentAmount;
  final String unity;
  const MaterialPercentageInfoCard({
    Key? key,
    required this.initialAmount,
    required this.currentAmount,
    required this.unity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(36, 24, 36, 24),
          height: 65,
          width: ((currentAmount * MediaQuery.of(context).size.width) /
              initialAmount),
          decoration: const BoxDecoration(
            color: Color.fromARGB(51, 126, 205, 201),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(36, 24, 36, 24),
          decoration: const BoxDecoration(
            color: Color.fromARGB(51, 126, 205, 201),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Disponível',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Flexible(
                child: Text(
                  '$currentAmount $unity (${(currentAmount * 100) ~/ initialAmount}%)',
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
