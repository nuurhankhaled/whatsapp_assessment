import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';

/// A circular badge widget that displays the number of unread messages
/// Similar to WhatsApp's unread message badge with green background and white text
class UnreadMessageBadge extends StatelessWidget {
  const UnreadMessageBadge({
    super.key,
    required this.count,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    // Don't show the badge if count is 0 or negative
    if (count <= 0) {
      return const SizedBox.shrink();
    }

    return Container(
      constraints: const BoxConstraints(
        minWidth: 20,
        minHeight: 20,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor, // WhatsApp green
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          count > 999 ? '999+' : count.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}