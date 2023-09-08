import 'dart:convert';
import 'dart:io';

import 'package:flutter_mvvm/data/app_exceptions.dart';
import 'package:flutter_mvvm/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http
              .get(Uri.parse(url)).timeout(const Duration(seconds: 3));
      responseJson =returnResponseJson(response);
    } on SocketException {
      throw FetchDataException('No internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url,  dynamic data)async {
    dynamic responseJson;
    try {
     Response response = await post(body: data,Uri.parse(url)).timeout(Duration(seconds: 10));
     responseJson =returnResponseJson(response);
    } on SocketException {
      throw FetchDataException('No internet Connection');
    }
    return responseJson;

  }
}

dynamic returnResponseJson(http.Response response) {
  switch (response.statusCode) {
    case 200:
      dynamic responseJson = jsonDecode(response.body);
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 404:
      throw UnauthorisedException(response.body.toString());
    case 500:

    default:
      throw FetchDataException('Error occured while communicating with server' +
          'with status code' +
          response.statusCode.toString());
  }
}
