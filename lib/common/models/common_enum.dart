enum IntervalEnum {
  none(label: '不重复'),
  daily(label: '每天'),
  monthly(label: '每月'),
  yearly(label: '每年');

  final String label;
  const IntervalEnum({required this.label});
}
