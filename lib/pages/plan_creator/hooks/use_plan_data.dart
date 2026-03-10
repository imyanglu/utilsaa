import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

({
  TextEditingController? nameTextController,
  DateTime? date,
  Function(DateTime?) changeDate,
})
usePlanForm() {
  final name = useTextEditingController();
  final date = useState<DateTime?>(null);
  return (
    nameTextController: name,
    date: date.value,
    changeDate: (d) => date.value = d,
  );
}
