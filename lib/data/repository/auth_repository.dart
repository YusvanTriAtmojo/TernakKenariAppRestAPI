import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kenari_app/data/model/request/auth/login_request_model.dart';
import 'package:kenari_app/data/model/request/auth/register_request_model.dart';
import 'package:kenari_app/data/model/response/auth_response_model.dart';
import 'package:kenari_app/services/service_http_client.dart';

class AuthRepository {
  final ServiceHttpClient _serviceHttpClient;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  AuthRepository(this._serviceHttpClient);

  Future<Either<String, AuthResponseModel>> login(
    LoginRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.post(
        "login",
        requestModel.toJson(),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final authResponse = AuthResponseModel.fromMap(jsonResponse); 

        final token = authResponse.user?.token;
        if (token != null) {
          await secureStorage.write(key: 'auth_token', value: token);
        }

        return Right(authResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown login error');
      }
    } catch (e) {
      return Left("An error occurred while logging in: $e");
    }
  }

  Future<Either<String, String>> register(
    RegisterRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.post(
        "register",
        requestModel.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final authResponse = AuthResponseModel.fromMap(jsonResponse);

        final token = authResponse.user?.token;
        if (token != null) {
          await secureStorage.write(key: 'auth_token', value: token);
          return Right("Registration successful");
        } else {
          return Left("Registration success but token missing");
        }
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown registration error');
      }
    } catch (e) {
      return Left("An error occurred while registering: $e");
    }
  }

  Future<String?> getToken() async {
    return await secureStorage.read(key: 'auth_token');
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }

  Future<void> logout() async {
    await secureStorage.delete(key: 'auth_token');
  }
}
