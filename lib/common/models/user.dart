enum UserField { adCode, email, address }

class User {
  final String? adCode;
  final String? email;

  final List<String>? address;
  User({this.adCode, this.email, this.address});
  User copyWith({String? adCode, String? email, List<String>? address}) {
    return User(
      adCode: adCode ?? this.adCode,
      email: email ?? this.email,
      address: address ?? this.address,
    );
  }

  User update(UserField field, dynamic value) {
    return switch (field) {
      UserField.adCode => copyWith(adCode: value as String),
      UserField.email => copyWith(email: value as String),
      UserField.address => copyWith(address: value as List<String>),
    };
  }

  @override
  String toString() {
    return 'User{城市编码: $adCode, 地址: $address}';
    // 或者更简洁的格式
    // return 'User(name: $name, age: $age)';
  }

  Map<String, dynamic> toJson() => {
    'adCode': adCode,
    'email': email,
    'address': address,
  };
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      adCode: json['adCode'],
      email: json['email'],
      address: json['address'],
    );
  }
}
