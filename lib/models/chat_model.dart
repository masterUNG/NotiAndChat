// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String chat;
  final Map<String, dynamic> mapChat;
  final Timestamp timestamp;
  ChatModel({
    required this.chat,
    required this.mapChat,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chat': chat,
      'mapChat': mapChat,
      'timestamp': timestamp,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chat: (map['chat'] ?? '') as String,
      mapChat: Map<String, dynamic>.from(map['mapChat'] ?? {}),
      timestamp: (map['timestamp']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
