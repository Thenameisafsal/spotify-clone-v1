// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:client/features/home/model/fav_song_model.dart';

class UserModel {
  final String name;
  final String userid;
  final String email;
  final String token;
  final List<FavSongModel> favorites;

  UserModel({
    required this.name,
    required this.userid,
    required this.email,
    required this.token,
    required this.favorites,
  });

  UserModel copyWith({
    String? name,
    String? userid,
    String? email,
    String? token,
    List<FavSongModel>? favorites,
  }) {
    return UserModel(
      name: name ?? this.name,
      userid: userid ?? this.userid,
      email: email ?? this.email,
      token: token ?? this.token,
      favorites: favorites ?? this.favorites,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'userid': userid,
      'email': email,
      'token': token,
      'favorites': favorites.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      userid: map['userid'] ?? '',
      email: map['email'] ?? '',
      token: map['token'] ?? '',
      favorites: List<FavSongModel>.from(
        (map['favorites'] ?? []).map<FavSongModel>(
          (x) => FavSongModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, userid: $userid, email: $email, token: $token, favorites: $favorites)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.userid == userid &&
        other.email == email &&
        other.token == token &&
        listEquals(other.favorites, favorites);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        userid.hashCode ^
        email.hashCode ^
        token.hashCode ^
        favorites.hashCode;
  }
}
