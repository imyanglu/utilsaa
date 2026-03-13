import 'package:flutter/material.dart';

import 'package:plan/common/widgets/weather.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: screenWidth, //
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: const [Color(0xffB8D8E3), Color(0xffE5D9CF)],
          ),
        ),
        child: SafeArea(
          maintainBottomViewPadding: false,
          child: Padding(
            padding: EdgeInsetsGeometry.all(12),
            child: Column(
              children: [
                Row(children: [Weather()]),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
