import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConditionalContainer extends StatelessWidget {
  final String cValue;

  ConditionalContainer({required this.cValue});

  @override
  Widget build(BuildContext context) {
    if (cValue == "0") {
      return Container(
          width: 20.0,
          height: 20.0,
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ));
    } else if (cValue == "1") {
      return Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              )));
    } else {
      return Container(
        width: 20.0,
        height: 20.0,
        alignment: Alignment.center,
        child: const Text(
          'X',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      );
    }
  }
}