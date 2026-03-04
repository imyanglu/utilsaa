import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music/common/widgets/weather.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: const [Color(0xffB8D8E3), Color(0xffE5D9CF)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.all(12),
            child: Column(children: [Weather()]),
          ),
        ),
      ),
    );
  }
}
