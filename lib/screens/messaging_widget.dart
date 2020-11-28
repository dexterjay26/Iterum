import 'package:flutter/material.dart';
import '../models/messages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MessageBuilder extends StatefulWidget {
  @override
  _MessageBuilderState createState() => _MessageBuilderState();
}

class _MessageBuilderState extends State<MessageBuilder> {
  final _firebaseMessaging = FirebaseMessaging();

  final List<Message> messages = [];

  @override
  void initState() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: messages.map((e) => buildMessage(e)).toList(),
    );
  }

  Widget buildMessage(Message message) {
    return ListTile(
      title: Text(message.title),
      subtitle: Text(message.body),
    );
  }
}
