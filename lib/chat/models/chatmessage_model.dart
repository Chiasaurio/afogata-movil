import 'package:flutter/material.dart';

class ChatMessage {
  String to;
  String from;
  bool read;
  String? file;
  String text;

  ChatMessage(
      {required this.to,
      required this.from,
      required this.read,
      required this.text});
}
