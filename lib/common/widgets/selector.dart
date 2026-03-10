import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:music/common/models/selector.dart';

class SelectorWidget<T extends Selector> extends HookWidget {
  final Widget trigger;
  final List<Selector> list;
  SelectorWidget({required this.trigger, required this.list});
  @override
  Widget build(BuildContext context) {
    final isOpen = useState(false);
    // TODO: implement build
    return PopupMenuButton<String>(
      icon: InkWell(
        onTap: null, // 禁用 InkWell 的点击效果
        splashFactory: NoSplash.splashFactory, // 取消水波纹
        highlightColor: Colors.transparent, // 取消高亮
        hoverColor: Colors.transparent, // 取消悬停
        child: trigger,
      ), // 触发按钮
      offset: Offset(0, 80), // 偏移量
      color: Colors.white,

      onSelected: (value) {
        print('选择了: $value');
      },
      itemBuilder: (context) {
        return list.map((e) {
          return PopupMenuItem(
            value: e.key,
            child: IntrinsicWidth(child: Container(child: Text("hello"))),
          );
        }).toList();
      },
    );
  }
}
