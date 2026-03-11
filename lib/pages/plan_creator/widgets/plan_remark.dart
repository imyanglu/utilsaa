import 'package:flutter/material.dart';

class PlanRemark extends StatelessWidget {
  final String remark;
  final String remarkTitle;

  const PlanRemark({Key? key, required this.remark, required this.remarkTitle})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("📌", style: TextStyle(fontSize: 16)),
            SizedBox(width: 4),
            Text(
              "备注(选填)",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff4F5F73),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        TextField(
          minLines: 5,
          maxLines: null, // 设置为 null 会随内容自动增高
          keyboardType: TextInputType.multiline, // 优化键盘布局
          decoration: InputDecoration(
            hintText: '备注...',

            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffF2F5F9)),
              borderRadius: BorderRadius.circular(12),
            ), // 加上边框更像传统的 TextArea
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffF2F5F9)),
              borderRadius: BorderRadius.circular(12),
            ), //
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffF2F5F9)),
              borderRadius: BorderRadius.circular(12),
            ), //
          ),
        ),
      ],
    );
  }
}
