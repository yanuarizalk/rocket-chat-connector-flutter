import 'dart:convert';

import 'package:rocket_chat_connector_flutter/web_socket/notification_args.dart';
import 'package:rocket_chat_connector_flutter/web_socket/notification_event.dart';

class NotificationFields {
  String eventName;
  List<NotificationArgs> args;
  NotificationEvent eventType;

  NotificationFields({
    this.eventName,
    this.args,
  });

  NotificationFields.fromMap(Map<String, dynamic> json) {
    if (json != null) {
      eventName = json['eventName'];
      if (eventName != null)
        eventType = notificationEventFromString(eventName.split('/').last);
      if (json['args'] != null) {
        List<dynamic> jsonList = json['args'].runtimeType == String //
            ? jsonDecode(json['args'])
            : json['args'];
        args = jsonList
            .where((json) => json != null)
            .map((json) => NotificationArgs.fromMap(json))
            .toList();
      } else {
        args = null;
      }
    }
  }

  @override
  String toString() {
    return 'WebSocketMessageFields{eventName: $eventName, args: $args}';
  }
}
