/// @desc [a simple class to otganize the REST API Operations

/// class is build on a singleton instance no need to initialize every time

/// @apiRequest is the method that handles all the REST API operations]

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sharekny_app/services/localization/app_localization.dart';
import 'package:sharekny_app/utilities/styles.dart';
import 'constants.dart';

class RequestType {
  static const String Get = "get";
  static const String Post = "post";
  static const String Put = "put";
  static const String Delete = "delete";
}

class Api {
  //singleton
  static final Api _apiInstance = Api._internal();
  Api._internal();
  static Api get instance => _apiInstance;

  Future<dynamic> apiRequest(
    String type,
    dynamic url,
  { Map<String, String>? headers,
    Map<String, dynamic>? body,}

  ) async {
    final _url = /*onstants.baseUrl + */ url;
    final _body = body == null ? null : jsonEncode(body);
    http.Response? response;
    final Map<String, String>? header =
        headers /*??
        {"Content-Type": "application/json", "Accept": "application/json"}*/
        ;
    // header["language"] = locator<LocalizationProvider>().locale.languageCode;
    //SEARCH WITH LANG TO UNCOMMENT
    //header["language"] = "en";
    //print(_url);
    //print(_body);
    //print(header);
    try {
      switch (type) {
        case RequestType.Get:
          {
            if (body != null) {
              Uri uri = Uri.parse(_url);
              // "language=${locator<LocalizationProvider>().locale.languageCode}");
              //SEARCH WITH LANG TO UNCOMMENT

              final newURI = uri.replace(queryParameters: body);

              response = await http.get(newURI, headers: header)
                  .timeout(const Duration(seconds: 20));
            } else {
              response = await http.get(_url, headers: header)
                  .timeout(const Duration(seconds: 20));
            }

          }
          break;
        case RequestType.Post:
          {
            response = await http.post(_url, headers: header, body: _body)
                .timeout(const Duration(seconds: 15));;
          }
          break;
        case RequestType.Put:
          {
            response = await http.put(_url, headers: header, body: _body)
                .timeout(const Duration(seconds: 20));;
          }
          break;
        case RequestType.Delete:
          {
            response = await http.delete(_url, headers: header)
                .timeout(const Duration(seconds: 15));;
          }
          break;
        default:
          break;
      }

      if (response?.statusCode == 200 || response?.statusCode == 201) {
        // print(response.body);
        return json
            .decode(utf8.decode(response!.bodyBytes)); //map of string dynamic...
      } else {
        if (Constants.isDebug) {
          print("ERROR statusCode in http $type for $_url: \n" + response!.body);
        }
        return null;
      }
    } catch (e) {
      if (Constants.isDebug) {
        print("ERROR in http $type for $_url: \n" + e.toString());
      }
    }
  }
  noConnection(context){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 800),
        backgroundColor: dangerColor,
        content: Text(
          AppLocalizations.of(context)!.translate("check_internet_connections"),
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );


  }
}
