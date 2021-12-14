enum NotificationEvent {
  // stream-notify-user
  MESSAGE, OTR, WEBRTC, NOTIFICATION, ROOMS_CHANGED, SUBSCRIPTIONS_CHANGED,
  // stream-notify-all
  PUBLIC_SETTINGS_CHANGED, PERMISSIONS_CHANGED,
  // stream-notify-logged
  USER_NAME_CHANGED, USER_DELETED, USER_STATUS,
  // stream-notify-room
  DELETE_MESSAGE, TYPING,
  // all & logged
  ROLES_CHANGE, UPDATE_EMOJI_CUSTOM, DELETE_EMOJI_CUSTOM, UPDATE_AVATAR,
  UNKNOWN
}

NotificationEvent notificationEventFromString(String notificationEvent) {
  if (notificationEvent == 'message') {
    return NotificationEvent.MESSAGE;
  } else if (notificationEvent == 'otr') {
    return NotificationEvent.OTR;
  } else if (notificationEvent == 'webrtc') {
    return NotificationEvent.WEBRTC;
  } else if (notificationEvent == 'notification') {
    return NotificationEvent.NOTIFICATION;
  } else if (notificationEvent == 'rooms-changed') {
    return NotificationEvent.ROOMS_CHANGED;
  } else if (notificationEvent == 'subscriptions-changed') {
    return NotificationEvent.SUBSCRIPTIONS_CHANGED;
  } else if (notificationEvent == 'rooms-changed') {
    return NotificationEvent.ROOMS_CHANGED;
  } else if (notificationEvent == 'rooms-changed') {
    return NotificationEvent.ROOMS_CHANGED;
  } else if (notificationEvent == 'rooms-changed') {
    return NotificationEvent.ROOMS_CHANGED;
  } else if (notificationEvent == 'rooms-changed') {
    return NotificationEvent.ROOMS_CHANGED;
  } else if (notificationEvent == 'rooms-changed') {
    return NotificationEvent.ROOMS_CHANGED;
  } else if (notificationEvent == 'rooms-changed') {
    return NotificationEvent.ROOMS_CHANGED;
  } else if (notificationEvent == 'rooms-changed') {
    return NotificationEvent.ROOMS_CHANGED;
  } else if (notificationEvent == 'rooms-changed') {
    return NotificationEvent.ROOMS_CHANGED;
  } else if (notificationEvent == 'rooms-changed') {
    return NotificationEvent.ROOMS_CHANGED;
  } else {
    return NotificationEvent.UNKNOWN;
  }
}
