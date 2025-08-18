import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/generated/assets.gen.dart';
import 'package:whatsapp_assessment/features/home/presentation/widgets/unread_message_badge.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    this.unreadCount = 0,
  });

  final int unreadCount;

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
                color: Colors.blue[100],
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D",
                  ),
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
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6), // Top padding
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Chat Title ',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '12:00PM',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  letterSpacing: 0,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2), // Fixed spacing
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.top,
                                      child: Image.asset(
                                        Assets.images.seenMessage.path,
                                        width: 16,
                                        height: 16,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          ' Last message preview for chewkjfh kewjfhkejf hkjhke wjfhkewfkat ',
                                      style: Theme.of(context).textTheme.bodySmall
                                          ?.copyWith(
                                            height: 1.2,
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textSecondary,
                                          ),
                                    ),
                                  ],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // Add spacing between message and badge
                            const SizedBox(width: 8),
                            // Unread message badge positioned at the same vertical level as message text
                            Align(
                              alignment: Alignment.centerRight,
                              child: UnreadMessageBadge(count: unreadCount),
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