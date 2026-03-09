import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FunImp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(color: Color(0xf0ffff)),
      child: Row(
        children: [
          Column(children: [Text("总歌曲"), Text("151首")]),
        ],
      ),
    );
  }
}
