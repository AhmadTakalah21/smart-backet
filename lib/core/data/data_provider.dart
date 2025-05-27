import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fresh_shelf/core/data/params_model.dart';
import 'package:fresh_shelf/l10n/local_provider.dart';

import '../../injection_container.dart';
import '../configuration/app_configurations.dart';
import '../exception/app_exception.dart';

abstract class RemoteDataSource {
  final Dio dio = sl<Dio>();

  Future<dynamic> get(ParamsModel model) async {
    var responseJson;

    try {
      final url = AppConfigurations.BaseUrl + model.url!;
      Map<String, dynamic> map = model.urlParams;
      map["lang"] = sl<LocaleProvider>().locale.languageCode;

      final response = await dio.get(
        url,
        queryParameters: map,
      );
      responseJson = _returnResponse(response);
    } on DioException catch (e) {
      if (e.response == null) throw NoInternetException();
      _returnResponse(e.response!);
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> post(ParamsModel model) async {
    Response response;
    var responseJson;
    try {
      final url = model.baseUrl ?? AppConfigurations.BaseUrl;
      if (model.body != null) {
        print(model.body!.toJson());
      }
      Map<String, dynamic> map = model.urlParams;
      map["lang"] = sl<LocaleProvider>().locale.languageCode;
      response = await dio.post(
        url + model.url.toString(),
        data: model.body?.toJson() ?? {},
        queryParameters: model.urlParams,
      );

      responseJson = _returnResponse(response);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.message);
        print(e.stackTrace);
      }
      if (e.response == null) throw NoInternetException();
      print(e.response);
      _returnResponse(e.response!);
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> put(ParamsModel model) async {
    Response response;
    var responseJson;
    try {
      final url = model.baseUrl ?? AppConfigurations.BaseUrl;
      if (model.body != null) {
        print(model.body!.toJson());
      }
      response = await dio.put(
        url + model.url.toString(),
        data: model.body?.toJson() ?? {},
        queryParameters: model.urlParams,
      );

      responseJson = _returnResponse(response);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.message);
        print(e.stackTrace);
      }
      if (e.response == null) throw NoInternetException();
      print(e.response);
      _returnResponse(e.response!);
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    final responseJson =
        response.toString().isEmpty ? null : json.decode(response.toString());

    switch (response.statusCode) {
      case 200:
      case 201:
        return responseJson;
      case 400:
        if (responseJson['error']['message'] == 'Invalid refresh token.') {
          throw SessionTimedOutException();
        }
        throw InvalidInputException(
          message: responseJson['error']['message'],
          data: responseJson,
        );
      case 409:
        throw InvalidInputException(
          message: responseJson['error']['message'],
        );

      case 401:
      case 403:
        throw UnauthorisedException(
          data: responseJson,
        );
      case 404:
        throw NotFoundException(data: responseJson);
      case 500:
        throw ServerErrorException(
            data: responseJson, message: responseJson['error']['message']);
      default:
        throw FetchDataException(
          message: 'Unknown Error',
        );
    }
  }
}
