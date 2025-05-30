import 'dart:convert';
import 'dart:math';

import 'package:rocket_chat_connector_flutter/models/authentication.dart';
import 'package:rocket_chat_connector_flutter/models/channel.dart';
import 'package:rocket_chat_connector_flutter/models/room.dart';
import 'package:rocket_chat_connector_flutter/models/user.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel connectToWebSocket(
      String url, Authentication authentication) {
    WebSocketChannel webSocketChannel = IOWebSocketChannel.connect(url);
    _sendConnectRequest(webSocketChannel);
    _sendLoginRequest(webSocketChannel, authentication);
    return webSocketChannel;
  }

  void _sendConnectRequest(WebSocketChannel webSocketChannel) {
    Map msg = {
      "msg": "connect",
      "version": "1",
      "support": ["1", "pre2", "pre1"]
    };
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void _sendLoginRequest(
      WebSocketChannel webSocketChannel, Authentication authentication) {
    Map msg = {
      "msg": "method",
      "method": "login",
      "id": "42",
      "params": [
        {"resume": authentication.data!.authToken}
      ]
    };

    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void streamNotifyUserSubscribe(WebSocketChannel webSocketChannel, User user) {
    Map msg = {
      "msg": "sub",
      "id": user.id! + "subscription-id",
      "name": "stream-notify-user",
      "params": [user.id! + "/notification", false]
    };

    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void streamChannelMessagesSubscribe(
      WebSocketChannel webSocketChannel, Channel channel) {
    Map msg = {
      "msg": "sub",
      "id": channel.id! + "subscription-id",
      "name": "stream-room-messages",
      "params": [channel.id, false]
    };
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void streamChannelMessagesUnsubscribe(
      WebSocketChannel webSocketChannel, Channel channel) {
    Map msg = {
      "msg": "unsub",
      "id": channel.id! + "subscription-id",
    };
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void streamRoomMessagesSubscribe(
      WebSocketChannel webSocketChannel, Room room) {
    Map msg = {
      "msg": "sub",
      "id": room.id! + "subscription-id",
      "name": "stream-room-messages",
      "params": [room.id, false]
    };
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void streamRoomMessagesUnsubscribe(
      WebSocketChannel webSocketChannel, Room room) {
    Map msg = {
      "msg": "unsub",
      "id": room.id! + "subscription-id",
    };
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void sendMessageOnChannel(
      String message, WebSocketChannel webSocketChannel, Channel channel) {
    Map msg = {
      "msg": "method",
      "method": "sendMessage",
      "id": "42",
      "params": [
        {"rid": channel.id, "msg": message}
      ]
    };

    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void streamLiveChatRoomSubscribe(
    WebSocketChannel webSocketChannel, String id, String roomId, String token, {
    bool agentInstead = false
  }) {
    Map msg = {
      "msg": "sub",
      "id": id ,
      "name": agentInstead ? "stream-livechat-room" : "stream-room-messages",
      // "name": "stream-livechat-room",
      "params": [
        roomId,
        {
          'useCollection': false,
          'args': [
            {'visitorToken': token}
          ]
        }
      ]
    };
    webSocketChannel.sink.add(jsonEncode(msg));
  }
  String liveChatCheck(WebSocketChannel webSocketChannel, String id, {
    String? token
  }) {
    token ??= _rand(43);
    Map msg = {
      "msg": "method",
      "method": "livechat:getInitialData",
      // "id": "lcr-${_rand(17)}",
      "id": "440",
      "params": [
        token
      ]
    };

    webSocketChannel.sink.add(jsonEncode(msg));
    return token;
  }
  /* Will return id
  * */
  void liveChatRegisterGuest(
    WebSocketChannel webSocketChannel,
    String id, {
      required String name, required String email, String? department,
      String? token
  }) {
    Map msg = {
      "msg": "method",
      "method": "livechat:registerGuest",
      // "id": "lcr-${_rand(17)}",
      "id": id,
      "params": [
        {
          "token": token ?? _rand(17), "name": name,
          "email": email, "department": department
        }
      ]
    };

    webSocketChannel.sink.add(jsonEncode(msg));
    //return id;
  }
  void liveChatSendMessage(
      WebSocketChannel webSocketChannel, String id, {
      required String rid, required String message, required String token
  }) {
    Map msg = {
      "msg": "method",
      "method": "sendMessageLivechat",
      //"id": "lcs-${_rand(17)}",
      "id": id,
      "params": [
        {
          "_id": "$rid/${_rand(17)}", "rid": rid,
          "token": token, "msg": message,
        }
      ]
    };

    webSocketChannel.sink.add(jsonEncode(msg));
  }
  String _rand(int length) {
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  void sendMessageOnRoom(
      String message, WebSocketChannel webSocketChannel, Room room) {
    Map msg = {
      "msg": "method",
      "method": "sendMessage",
      "id": "42",
      "params": [
        {"rid": room.id, "msg": message}
      ]
    };

    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void sendUserPresence(WebSocketChannel webSocketChannel) {
    Map msg = {
      "msg": "method",
      "method": "UserPresence:setDefaultStatus",
      "id": "42",
      "params": ["online"]
    };
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  /*void listen({
    String channel, Function func
  }) {

  }*/
}
