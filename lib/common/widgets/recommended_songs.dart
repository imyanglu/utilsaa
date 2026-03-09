import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RecommendedSongs extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "今日推荐",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.from(
                    alpha: 0.75,
                    red: 255,
                    green: 255,
                    blue: 255,
                  ),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffCAD8DA),
                  foregroundColor: Color(0xff73BBF0),
                  side: BorderSide(color: Color(0xff73BBF0), width: 0.8),
                ),
                child: Text("更多"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
