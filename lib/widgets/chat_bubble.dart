// ignore_for_file: prefer_const_constructors

import 'package:chat_app/models/messages.dart';
import 'package:flutter/material.dart';

class chatbubble extends StatelessWidget {
  const chatbubble({
    super.key,
    required this.message,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 10, top: 16, bottom: 16, right: 16),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 31, 33, 62),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16))),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class chatbubbleSecondUser extends StatelessWidget {
  const chatbubbleSecondUser({
    super.key,
    required this.message,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 10),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 139, 51, 72),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16))),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
