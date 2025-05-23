import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rocket_chat_connector_flutter/models/authentication.dart';
import 'package:rocket_chat_connector_flutter/models/new/message_new.dart';
import 'package:rocket_chat_connector_flutter/models/response/message_new_response.dart';
import 'package:rocket_chat_connector_flutter/services/http_service.dart';
import 'package:rocket_chat_connector_flutter/services/message_service.dart';

import '../scenarios/data/response/message_new_response_data.dart';
import 'message_service_test.mocks.dart';

@GenerateMocks([HttpService])
void main() {
  HttpService? httpServiceMock;
  late MessageService messageService;
  Authentication authenticationMock = new Authentication();

  MessageNew message = MessageNew(channel: "#general", text: "This is a test!");

  setUp(() async {
    httpServiceMock = MockHttpService();
    messageService = MessageService(httpServiceMock!);
  });

  test('post message', () async {
    Response response =
        Response(jsonEncode(MessageNewResponseData.getMapById(1)), 200);
    when(httpServiceMock!.post(
      "/api/v1/chat.postMessage",
      jsonEncode(message.toMap()),
      authenticationMock,
    )).thenAnswer((_) => Future(() => response));

    messageService.authentication = authenticationMock;
    MessageNewResponse messageResponse =
        await messageService.postMessage(message);
    expect(messageResponse.success, true);
  });
}
