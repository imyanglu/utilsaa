enum PlanLabel {
  personal(label: '个人', icon: '❤️', key: 'personal'),
  work(label: '工作', icon: '💼', key: 'work'),

  school(label: '学校', icon: '🏫', key: 'school'),
  family(label: '家庭', icon: '🏠', key: 'family'),
  health(label: '健康', icon: '🏋️', key: 'health'),
  study(label: '学习', icon: '📚 ', key: 'study'),
  other(label: '其他', icon: '📝', key: 'other');

  final String key;
  final String label;
  final String icon;
  const PlanLabel({required this.label, required this.icon, required this.key});
}
