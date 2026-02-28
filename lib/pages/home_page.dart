import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music/common/widgets/weather.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(12),
          child: Column(children: [Weather()]),
        ),
      ),
    );
  }
}
