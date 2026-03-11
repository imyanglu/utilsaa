enum IntervalEnum {
  norepeat(label: '不重复'),
  weekly(label: '每周'),
  monthly(label: '每月'),
  daily(label: '每天'),
  other(label: '自定义');

  final String label;
  const IntervalEnum({required this.label});
}
