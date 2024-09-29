import 'dart:convert';
import 'package:client/core/failure/failure.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  // Either<error case, success case> format
  Future<Either<AppFailure, UserModel>> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/auth/signup'),
        // convert to json so that the backend understands it
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            'name': name,
            'email': email,
            'password': password,
          },
        ),
      );
      final resBody = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 201) {
        // error case
        return Left(AppFailure(resBody[
            'detail'])); // left here indicates the wrong statement -> it comes from fp dart -> functional programming
      }
      return Right(UserModel.fromMap(resBody)); // the correct statement
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            'email': email,
            'password': password,
          },
        ),
      );
      final resBody = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        return Left(AppFailure(resBody['detail']));
      }
      return Right(UserModel.fromMap(resBody));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
