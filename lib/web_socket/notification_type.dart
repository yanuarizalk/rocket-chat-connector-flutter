enum NotificationType { CONNECTED, RESULT, UPDATED, CHANGED, READY, PING, NOSUB, UNKNOWN }

NotificationType notificationTypeFromString(String? notificationType) {
  if (notificationType == 'connected') {
    return NotificationType.CONNECTED;
  } else if (notificationType == 'result') {
    return NotificationType.RESULT;
  } else if (notificationType == 'updated') {
    return NotificationType.UPDATED;
  } else if (notificationType == 'changed') {
    return NotificationType.CHANGED;
  } else if (notificationType == 'ping') {
    return NotificationType.PING;
  } else if (notificationType == 'ready') {
    return NotificationType.READY;
  } else if (notificationType == 'nosub') {
    return NotificationType.NOSUB;
  } else {
    return NotificationType.UNKNOWN;
  }
}
