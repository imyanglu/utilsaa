import 'package:flutter/material.dart';

class BackBut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 46,
        height: 46,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          color: Color(0xffeEF2F7),
        ),
        child: Center(child: Icon(Icons.arrow_back)),
      ),
    );
  }
}
