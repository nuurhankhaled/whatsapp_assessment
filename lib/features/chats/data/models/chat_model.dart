import 'package:whatsapp_assessment/core/enum/message_status_enum.dart';

class ChatModel {
  final String id;
  final Sender sender;
  final String lastMessage;
  final DateTime timestamp;
  final MessageStatusEnum status;
  final int numberOfUnreadMessages;

  ChatModel({
    required this.id,
    required this.status,
    required this.sender,
    required this.lastMessage,
    required this.timestamp,
    required this.numberOfUnreadMessages,
  });
}

class Sender {
  final String name;
  final String image;
  Sender({required this.name, required this.image});
}
