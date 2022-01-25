



import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../app_locale.dart';
import '../util/nothing.dart';
import '../util/request_type.dart';
import '../util/request_type_exception.dart';

class network_client {
  static String Url =
      "http://bronze.fingerprint.ml"; //"http://www.phaarabiapp.com";
  static String _baseUrl = Url;

  final Client _client;

  network_client(this._client);

  Future<Response> request(
      {@required RequestType requestType,
        @required String path,
        dynamic parameter = Nothing}) async {
    switch (requestType) {
      case RequestType.GET:
        // if (AppLocale().token != null)
          return _client.get(Uri.parse("$_baseUrl/$path"), headers: {
            "Content-Type": "application/json",
            // "locale": AppLocale().locale.languageCode,
            "Authorization": "Bearer "
                // + AppLocale().token
          });
        // else
        //   return _client.get(Uri.parse("$_baseUrl/$path"), headers: {
        //     "Content-Type": "application/json",
        //     "locale": AppLocale().locale.languageCode
        //   });
        break;
      case RequestType.POST:
        return _client.post(Uri.parse("$_baseUrl/$path"),
            headers: {"Content-Type": "application/json"},
            body: json.encode(parameter));
      case RequestType.DELETE:
        return _client.delete(Uri.parse("$_baseUrl/$path"));
      default:
        return throw RequestTypeNotFoundException(
            "The HTTP request mentioned is not found");
    }
  }
}
