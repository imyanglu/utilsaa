enum UserField { cityCode, email, district }

class User {
  final String? cityCode;
  final String? email;
  final String? district;
  User({this.cityCode, this.email, this.district});
  User copyWith({String? cityCode, String? email, String? district}) {
    return User(
      cityCode: cityCode ?? this.cityCode,
      email: email ?? this.email,
      district: district ?? this.district,
    );
  }

  User update(UserField field, dynamic value) {
    return switch (field) {
      UserField.cityCode => copyWith(cityCode: value as String),
      UserField.email => copyWith(email: value as String),
      UserField.district => copyWith(district: district as String),
    };
  }

  Map<String, dynamic> toJson() => {
    'cityCode': cityCode,
    'email': email,
    'district': district,
  };
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      cityCode: json['cityCode'],
      email: json['email'],
      district: json['district'],
    );
  }
}
