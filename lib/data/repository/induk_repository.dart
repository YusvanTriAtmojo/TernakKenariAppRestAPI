import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:kenari_app/data/model/request/admin/induk_request_model.dart';
import 'package:kenari_app/data/model/response/get_all_induk_response.dart';
import 'package:kenari_app/services/service_http_client.dart';

class IndukRepository {
  final ServiceHttpClient _serviceHttpClient;

  IndukRepository(this._serviceHttpClient);

  Future<Either<String, GetIndukById>> addInduk(
    IndukRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.postWithToken(
        "admin/induk",
        requestModel.toJson(),
      );

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final profileResponse = GetIndukById.fromJson(jsonResponse);
        return Right(profileResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return Left("An error occurred while adding induk: $e");
    }
  }
}