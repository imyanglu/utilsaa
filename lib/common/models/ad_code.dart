class AdCode {
  final String? name;
  final String? adCode;
  final Map<String, AdCode> children;
  AdCode(this.adCode, this.children, this.name);

  factory AdCode.fromJson(Map<String, dynamic> json) {
    return AdCode(
      json['adCode'],
      Map.fromEntries(
        (json['children'] as List).map(
          (e) => MapEntry(e['adCode'], AdCode.fromJson(e)),
        ),
      ),
      json['name'],
    );
  }
}
