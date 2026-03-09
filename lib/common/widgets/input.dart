import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Input extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xffE2EAF3), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(
              color: Color(0xffE2EAF3),
              width: 1,
            ), // 聚焦时改变颜色更好
          ),

          // 提示文本
          hintText: '请输入',
          hintStyle: TextStyle(color: Color(0xff9B9B9B), fontSize: 14),
        ),
      ),
    );
  }
}

// ({String value, Widget Input}) useInput() {
//   final value = useState('');
//   return (
//     value: value.value,
//     Input: TextField(
//       onChanged: (v) {
//         value.value = v;
//       },
//     ),
//   );
// }
