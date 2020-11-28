import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class Messaging {
  static const GOOGLE_API_KEY = 'AIzaSyCZsyloia8iv2jxbGxNw5SYnNPBzl1ux0U';
  static const String serverKey =
      '	AAAAD1dC3Ek:APA91bF1GuYO4MLNt4oNECQNIY9s9Jj48JiIrfCmCHTZv41vm4lWm5jVF3Hwwk7wsbPQlnBkYgJhOW7qcA40fQVMAe_4A1Akmz2duRHYIBkwj5DIAlMn1dNX0qzhj9KtjvIOEvlq7RPB';

  static Future<http.Response> sendToAll({
    @required String title,
    @required String body,
  }) {
    sendToTopic(title: title, body: body, topic: 'all');
  }

  static Future<http.Response> sendToTopic(
          {@required String title,
          @required String body,
          @required String topic}) =>
      sendTo(title: title, body: body, fcmToken: '/topics/$topic');

  static Future<http.Response> sendTo({
    @required String title,
    @required String body,
    @required String fcmToken,
  }) =>
      http.post(
        'https://fcm.googleapis.com/fcm/send',
        body: json.encode({
          'notification': {'body': '$body', 'title': '$title'},
          'priority': 'high',
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
          },
          'to': '$fcmToken',
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
      );

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await http.get(url);

    return await json.decode(response.body)['results'][0]['formatted_address'];
  }
}
