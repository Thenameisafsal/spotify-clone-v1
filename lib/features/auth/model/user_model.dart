// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String name;
  final String userid;
  final String email;

  UserModel({
    required this.name,
    required this.userid,
    required this.email,
  });

  UserModel copyWith({
    String? name,
    String? userid,
    String? email,
  }) {
    return UserModel(
      name: name ?? this.name,
      userid: userid ?? this.userid,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'userid': userid,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      userid: map['userid'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(name: $name, userid: $userid, email: $email)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.userid == userid && other.email == email;
  }

  @override
  int get hashCode => name.hashCode ^ userid.hashCode ^ email.hashCode;
}
