import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Color.fromARGB(255, 126, 205, 201),
        ),
      ),
    );
  }
}
