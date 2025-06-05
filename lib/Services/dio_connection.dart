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
  Future<dynamic> getMethod(String url, {String? token}) async {
    dio.options.headers['content-Type'] = 'application/json'; //تعیین نوع هدر
    try {
      return await dio
          .get(url,
              options: Options(
                responseType: ResponseType.json,
                method: 'GET',
                headers: token != null
                    ? {
                        'Authorization': 'Bearer $token',
                        'Content-Type': 'application/json',
                      }
                    : {
                        // 'Authorization': 'Bearer $token',
                        'Content-Type': 'application/json',
                      },
              ))
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

  // ویرایش اطلاعات کاربر
  // این متد فقط فیلدهای غیر null را ارسال می‌کند
  Future<Response> updateUserInfo({
    required String url,
    required String token,
    String? name,
    bool? userSubscribers,
  }) async {
    // فقط فیلدهای غیر null ارسال بشن
    final data = <String, dynamic>{};
    if (name != null) data['namefmaily'] = name;
    if (userSubscribers != null) data['userSubscribers'] = userSubscribers;

    try {
      final response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      log(response.toString());
      return response;
    } catch (e) {
      debugPrint("Dio Error: $e");
      rethrow;
    }
  }

  // تایید کد ارسال شده به کاربر
  Future<dynamic> postSendedCode(String url, String mobile, int code) async {
    return await dio.post(url, data: {"mobile": mobile.trim(), "code": code});
  }
}
