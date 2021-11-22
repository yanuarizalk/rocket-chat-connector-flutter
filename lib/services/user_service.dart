import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:rocket_chat_connector_flutter/exceptions/exception.dart';
import 'package:rocket_chat_connector_flutter/models/authentication.dart';
import 'package:rocket_chat_connector_flutter/models/filters/filter.dart';
import 'package:rocket_chat_connector_flutter/models/new/user_new.dart';
import 'package:rocket_chat_connector_flutter/models/user.dart';
import 'package:rocket_chat_connector_flutter/services/http_service.dart';

class UserService {
  HttpService _httpService;
  Authentication authentication;

  UserService(this._httpService);

  Future<User> create(UserNew userNew, Authentication authentication) async {
    http.Response response = await _httpService.post(
      '/api/v1/users.create',
      jsonEncode(userNew.toMap()),
      authentication,
    );

    if (response?.statusCode == 200) {
      if (response?.body?.isNotEmpty == true) {
        return User.fromMap(jsonDecode(response.body));
      } else {
        return User();
      }
    }
    throw RocketChatException(response?.body);
  }

  Future<Uint8List> getAvatar({ String username, String userId }) async {
    http.Response response = await _httpService.getWithFilter(
      '/api/v1/users.getAvatar',
      null,
      authentication,
      query: {
        'userId': userId, 'username': username
      }
    );

    if (response?.statusCode == 200) {
      if (response?.body?.isNotEmpty == true) {
        return response.bodyBytes;
      } else {
        return null;
      }
    }
    throw RocketChatException(response?.body);
  }

  Future<User> getInfo({ String username, String userId, bool rawMap = true }) async {
    http.Response response = await _httpService.getWithFilter(
        '/api/v1/users.info',
        null,
        authentication,
        query: {
          'userId': userId, 'username': username
        }
    );

    if (response?.statusCode == 200) {
      if (response?.body?.isNotEmpty == true) {
        var decoded = jsonDecode(response.body);
        // return decoded;
        if (decoded['success'])
          return User.fromMap(decoded['user']);
        return null;
      } else {
        return null;
      }
    }
    throw RocketChatException(response?.body);
  }
}
