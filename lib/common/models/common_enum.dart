enum IntervalEnum {
  none(label: '不重复'),
  daily(label: '每天');

  final String label;
  const IntervalEnum({required this.label});
}
