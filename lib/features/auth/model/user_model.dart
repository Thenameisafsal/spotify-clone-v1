// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String name;
  final String userid;
  final String email;
  final String token;

  UserModel({
    required this.name,
    required this.userid,
    required this.email,
    required this.token,
  });

  UserModel copyWith({
    String? name,
    String? userid,
    String? email,
    String? token,
  }) {
    return UserModel(
      name: name ?? this.name,
      userid: userid ?? this.userid,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'userid': userid,
      'email': email,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      userid: map['userid'] ?? '',
      email: map['email'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, userid: $userid, email: $email, token: $token)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.userid == userid &&
        other.email == email &&
        other.token == token;
  }

  @override
  int get hashCode {
    return name.hashCode ^ userid.hashCode ^ email.hashCode ^ token.hashCode;
  }
}
