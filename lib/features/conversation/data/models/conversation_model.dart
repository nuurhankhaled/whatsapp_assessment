import 'package:whatsapp_assessment/core/enum/message_status_enum.dart';
import 'package:whatsapp_assessment/features/conversation/enum/message_types_enum.dart';

class ConversationModel {
  final Sender sender;
  final List<MessageModel> messages;
  ConversationModel(this.sender, this.messages);
}

class MessageModel {
  final int id;
  final MessageType type;
  final String? text;
  final String? imageUrl;
  final bool isSender;
  final String time;
  final MessageStatusEnum messageStatus;
  MessageModel(
    this.id,
    this.type,
    this.text,
    this.imageUrl,
    this.isSender,
    this.time,
    this.messageStatus,
  );
}

class Sender {
  final String name;
  final String imageUrl;
  Sender(this.name, this.imageUrl);
}
