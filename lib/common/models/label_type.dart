enum PlanLabel {
  work(label: '工作', icon: '💼'),
  personal,
  school,
  family,
  health,
  study,
  other;

  final String? label;
  final String? icon;
  const PlanLabel({this.label, this.icon});
}
