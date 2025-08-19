import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/core/functions/date_format.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/features/chats/data/models/chat_model.dart';
import 'package:whatsapp_assessment/features/chats/enum/message_status_enum.dart';
import 'package:whatsapp_assessment/generated/assets.gen.dart';

class ChatCard extends StatelessWidget {
  final ChatModel model;
  const ChatCard({super.key, required this.model});

  String _getStatusIcon() {
    switch (model.status) {
      case MessageStatusEnum.sent:
        return Assets.images.sentMessage.path; // You might want different icons
      case MessageStatusEnum.delivered:
        return Assets.images.deliveredMessage.path;
      case MessageStatusEnum.seen:
        return Assets.images.seenMessage.path;
      case MessageStatusEnum.recived:
        return ''; // No icon for received messages
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 77,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          spacing: 12.3,
          children: [
            Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withAlpha(30),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(model.sender.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.lightGreyBackground),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10), // Top padding
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              model.sender.name,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            formatChatTimestamp(model.timestamp),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  letterSpacing: 0,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w500,
                                  color: model.numberOfUnreadMessages > 0
                                      ? const Color(
                                          0xFF1DAB61,
                                        ) // Green for unread
                                      : AppColors.textSecondary,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    // Only show status icon for non-received messages
                                    if (model.status !=
                                            MessageStatusEnum.recived &&
                                        _getStatusIcon().isNotEmpty)
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.top,
                                        child: Image.asset(
                                          _getStatusIcon(),
                                          width: 16,
                                          height: 16,
                                        ),
                                      ),
                                    TextSpan(
                                      text:
                                          model.status !=
                                              MessageStatusEnum.recived
                                          ? ' ${model.lastMessage}'
                                          : model.lastMessage,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            height: 1.2,
                                            fontSize: 12.5,
                                            fontWeight:
                                                model.numberOfUnreadMessages > 0
                                                ? FontWeight
                                                      .w500 // Bold for unread
                                                : FontWeight.w400,
                                            color: AppColors.textSecondary,
                                          ),
                                    ),
                                  ],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Unread badge widget built inline
                            if (model.numberOfUnreadMessages > 0)
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Container(
                                  constraints: const BoxConstraints(
                                    minWidth: 20,
                                  ),
                                  height: 20,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF1DAB61), // WhatsApp green
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      model.numberOfUnreadMessages > 99
                                          ? '99+'
                                          : model.numberOfUnreadMessages
                                                .toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
