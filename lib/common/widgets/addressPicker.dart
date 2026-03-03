import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:music/common/models/ad_code.dart';
import 'package:music/common/utils/help.dart';

class Addresspicker extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final adCodeMap = useState<Map<String, AdCode>?>(null);
    final address = useState<List<String>?>(null);
    init() async {
      final json = await loadCityCode();
      adCodeMap.value = AdCode.fromJson(json);
      address.value = [];
    }

    useEffect(() {}, []);
    return Container(
      padding: EdgeInsets.only(top: 12, left: 12, right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, -3), // 负值让阴影朝上（顶部）
          ),
        ],

        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); //
                },
                child: Text(
                  "取消",
                  style: TextStyle(
                    color: Color.fromARGB(255, 121, 120, 120),
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                "确认",
                style: TextStyle(color: Color(0xff6B9D4F), fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
