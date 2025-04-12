import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final Dio dio = Dio(BaseOptions(
  connectTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 15),
  sendTimeout: const Duration(seconds: 15),
));

class DioServices {
  DioServices() {
    try {
      // غیرفعال کردن بررسی SSL
      (dio.httpClientAdapter as dynamic).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    } catch (e) {
      debugPrint("Dio Error: $e");
    }
  }
  Future<dynamic> getMethod(String url) async {
    dio.options.headers['content-Type'] = 'application/json'; //تعیین نوع هدر
    try {
      return await dio
          .get(url,
              options: Options(responseType: ResponseType.json, method: 'GET'))
          .then((responseval) {
        log(responseval.toString());
        return responseval;
      });
    } catch (e) {
      debugPrint("Dio Error: $e");
      rethrow; // یا مدیریت خطای بهتر
    }
  }

  // ارسال کد به کاربر
  Future<dynamic> postMethod(String url, String mobile) async {
    return await dio.post(url, data: {
      "mobile": mobile.trim(),
      "templateId": 0,
      "parameters": [
        {"key": "string", "value": "string"}
      ]
    });
  }

  // تایید کد ارسال شده به کاربر
  Future<dynamic> postSendedCode(String url, String mobile, int code) async {
    return await dio.post(url, data: {"mobile": mobile.trim(), "code": code});
  }
}
