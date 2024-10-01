import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiService {
  static const String baseUrl = "https://www.episodate.com/api/";

  static Uri getUrl(String methodName) {
    if (methodName.contains("http")) {
      return Uri.parse(methodName);
    } else {
      return Uri.parse(baseUrl + methodName);
    }
  }

  /// GET
  static Future<dynamic> get(String url,
      {Map<String, String>? headerMap}) async {
    dynamic responseJson;
    if (kDebugMode) {
      print(getUrl(url));
    }
    try {
      http.Response response;
      if (headerMap == null) {
        response = await http.get(getUrl(url));
      } else {
        response = await http.get(getUrl(url), headers: headerMap);
      }
      responseJson = returnResponse(response);
    } on SocketException {
      throw 'No Internet Connection';
    }
    return responseJson;
  }

  /// POST
  static Future<dynamic> post(String url,
      {required Map<String, dynamic>? params,
      Map<String, String>? headerMap}) async {
    dynamic responseJson;
    if (kDebugMode) {
      print(getUrl(url));
      print(params);
    }
    try {
      if (params == null) {
        throw 'Parameters cannot be null';
      }
      var response =
          await http.post(getUrl(url), body: params, headers: headerMap);
      responseJson = returnResponse(response);
    } on SocketException {
      throw 'No Internet Connection';
    }
    return responseJson;
  }

  /// POST2
  static Future<dynamic> post2(String url,
      {required Map<String, dynamic>? params,
      Map<String, String>? headerMap}) async {
    dynamic responseJson;
    if (kDebugMode) {
      print(getUrl(url));
      print(params);
    }
    try {
      if (params == null) {
        throw 'Parameters cannot be null';
      }
      var response = await http.post(getUrl(url),
          body: jsonEncode(params), headers: headerMap);

      responseJson = returnResponse(response);
    } on SocketException {
      throw 'No Internet Connection';
    }
    return responseJson;
  }

  ///POST WITHOUT BODY
  static Future<dynamic> postWithoutBody(String url,
      {Map<String, dynamic>? params, Map<String, String>? headerMap}) async {
    dynamic responseJson;
    if (kDebugMode) {
      print(getUrl(url));
      print(params);
    }

    try {
      http.Response response;
      if (params == null) {
        response = await http.post(getUrl(url), headers: headerMap);
      }

      if (headerMap == null) {
        response = await http.post(
          getUrl(url),
          body: params,
        );
      } else {
        response = await http.post(
          getUrl(url),
          headers: headerMap,
          body: params,
        );
      }
      /*var response = await http.post(getUrl(url),
          body: params, headers: headerMap != null ? headerMap : appHeaderMap);*/

      responseJson = returnResponse(response);
    } on SocketException {
      throw 'No Internet Connection';
    }
    return responseJson;
  }

  /// MULTIPART
  static Future<dynamic> multipart(
    String url, {
    required Map<String, dynamic> files,
    required Map<String, String> headerMap,
    Map<String, String>? params,
  }) async {
    dynamic responseJson;
    if (kDebugMode) {
      print(getUrl(url));
      print(files);
    }
    try {
      var request = http.MultipartRequest('POST', getUrl(url));

      files.forEach((key, value) async {
        request.files.add(await http.MultipartFile.fromPath(key, value,
            contentType: MediaType("image", value.split(".").last)));
      });

      request.headers.addAll(headerMap);

      if (params != null) {
        request.fields.addAll(params);
      }

      http.StreamedResponse res = await request.send();
      final response = await http.Response.fromStream(res);
      responseJson = returnResponse(response);
    } on SocketException {
      throw 'No Internet connection';
    }
    return responseJson;
  }

  /// MULTIPART FROM BYTES
  static Future<dynamic> multipartFromBytes(String url,
      {required Map<String, dynamic> files,
      required Map<String, String> headerMap}) async {
    dynamic responseJson;
    if (kDebugMode) {
      print(getUrl(url));
      print(files);
    }
    try {
      var request = http.MultipartRequest('POST', getUrl(url));
      files.forEach((key, value) async {
        request.files.add(http.MultipartFile(
            key, http.ByteStream.fromBytes(value), value.length,
            filename: "image.jpeg", contentType: MediaType("image", "jpeg")));
      });
      request.headers.addAll(headerMap);
      http.StreamedResponse res = await request.send();
      final response = await http.Response.fromStream(res);
      responseJson = returnResponse(response);
    } on SocketException {
      throw 'No Internet connection';
    }
    return responseJson;
  }

  ///PATCH
  static Future<dynamic> patch(String url,
      {required Map<String, dynamic>? params,
      Map<String, String>? headerMap}) async {
    dynamic responseJson;
    if (kDebugMode) {
      print(getUrl(url));
      print(params);
      print(headerMap);
    }
    try {
      if (params == null) {
        throw 'Parameters cannot be null';
      }
      var response =
          await http.patch(getUrl(url), body: params, headers: headerMap);

      responseJson = returnResponse(response);
    } on SocketException {
      throw 'No Internet connection';
    }
    return responseJson;
  }

  ///PATCH2
  static Future<dynamic> patch2(String url,
      {required Map<String, dynamic>? params,
      Map<String, String>? headerMap}) async {
    dynamic responseJson;
    if (kDebugMode) {
      print(getUrl(url));
      print(params);
      print(headerMap);
    }
    try {
      if (params == null) {
        throw 'Parameters cannot be null';
      }
      var response = await http.patch(getUrl(url),
          body: jsonEncode(params), headers: headerMap);

      responseJson = returnResponse(response);
    } on SocketException {
      throw 'No Internet connection';
    }
    return responseJson;
  }

  ///  PUT
  static Future<dynamic> put(String url,
      {Map<String, String>? params, Map<String, String>? headerMap}) async {
    dynamic responseJson;

    if (kDebugMode) {
      print(getUrl(url));
      print(params);
      print(headerMap);
    }
    try {
      http.Response response;
      if (params == null) {
        response = await http.put(getUrl(url), headers: headerMap);
      } else {
        response =
            await http.put(getUrl(url), body: params, headers: headerMap);
      }

      responseJson = returnResponse(response);
    } on SocketException {
      throw 'No Internet Connection';
    }
    return responseJson;
  }

  ///DELETE

  static Future<dynamic> delete(String url,
      {Map<String, String>? headerMap, Map<String, dynamic>? params}) async {
    dynamic responseJson;
    if (kDebugMode) {
      print(getUrl(url));
    }
    try {
      http.Response response;
      if (headerMap == null && params == null) {
        response = await http.delete(getUrl(url));
      } else if (params == null) {
        response = await http.delete(getUrl(url), headers: headerMap);
      } else {
        response =
            await http.delete(getUrl(url), headers: headerMap, body: params);
      }
      responseJson = returnResponse(response);
    } on SocketException {
      throw 'No Internet Connection';
    }
    return responseJson;
  }

  @visibleForTesting
  static dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 201:
        return jsonDecode(response.body);
      case 204:
        return {};
      case 400:
        throw getMessage(response);
      case 401:
        throw getMessage(response);
      case 403:
        throw getMessage(response);
      case 500:
        throw getMessage(response);
      case 404:
        throw getMessage(response);
      case 406:
        throw getMessage(response);

      default:
        throw 'Error occurred while communication with server with status code : ${response.statusCode}';
    }
  }

  static String getMessage(http.Response response) {
    dynamic responseJson = jsonDecode(response.body);
    String? msg = responseJson['message'];
    if (msg != null) {
      return msg;
    } else {
      return "ERROR ${response.statusCode} - NO ERROR MESSAGE RECEIVED FROM BACKEND ";
    }
  }
}
