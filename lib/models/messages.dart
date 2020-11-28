import 'package:flutter/foundation.dart';

class Message {
  final String title;
  final String body;

  const Message(
    {
      @required this.title,
      @required this.body,
    }
  );
}