import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rocket_chat_connector_flutter/exceptions/exception.dart';
import 'package:rocket_chat_connector_flutter/models/authentication.dart';
import 'package:rocket_chat_connector_flutter/models/message.dart';
import 'package:rocket_chat_connector_flutter/models/new/message_new.dart';
import 'package:rocket_chat_connector_flutter/models/response/message_new_response.dart';
import 'package:rocket_chat_connector_flutter/services/http_service.dart';

class MessageService {
  HttpService _httpService;
  Authentication authentication;

  MessageService(this._httpService);

  Future<MessageNewResponse> postMessage(
      MessageNew message) async {
    http.Response response = await _httpService.post(
      '/api/v1/chat.postMessage',
      jsonEncode(message.toMap()),
      authentication,
    );

    if (response?.statusCode == 200) {
      if (response?.body?.isNotEmpty == true) {
        return MessageNewResponse.fromMap(jsonDecode(response.body));
      } else {
        return MessageNewResponse();
      }
    }
    throw RocketChatException(response?.body);
  }

  Future<Message> getMessage({ String msgId }) async {
    http.Response response = await _httpService.getWithFilter(
        '/api/v1/chat.getMessage',
        null,
        authentication,
        query: {
          'msgId': msgId
        }
    );

    if (response?.statusCode == 200) {
      if (response?.body?.isNotEmpty == true) {
        return Message.fromMap(jsonDecode(response.body));
      } else {
        return null;
      }
    }
    throw RocketChatException(response?.body);
  }
  Future<Map<String, dynamic>> syncMessage(
    String roomId, DateTime sinceWhen,
  ) async {
    http.Response response = await _httpService.getWithFilter(
        '/api/v1/chat.syncMessages',
        null,
        authentication,
        query: {
          'roomId': roomId,
          'lastUpdate': sinceWhen.toIso8601String()
        }
    );
    dynamic result;

    if (response?.body?.isNotEmpty == true) {
      result = jsonDecode(response.body);
      /*if (result['success'])
        return result;*/
      // else throw RocketChatException(response.body);
    } else {
      return null;
    }
    return result;
    // throw RocketChatException(response?.body);
  }
  Future<Map<String, dynamic>> loadLivechatHistory(
    String roomId, String token, {
      DateTime start, DateTime end, int limit
  }) async {
    http.Response response = await _httpService.getWithFilter(
      '/api/v1/livechat/messages.history/$roomId',
      null,
      null,
      query: {
        'token': token,
        'ls': start.toIso8601String(),
        'end': end?.toIso8601String(),
        'limit': limit,
      }
    );
    dynamic result;

    if (response?.body?.isNotEmpty == true) {
      result = jsonDecode(response.body);
    } else {
      return null;
    }
    return result;
  }
}
