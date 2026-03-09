import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Selector extends HookWidget {
  final Widget trigger;
  Selector({required this.trigger});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [GestureDetector(onTap: () {}, child: trigger)],
    );
  }
}
