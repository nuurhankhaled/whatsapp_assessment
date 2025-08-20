import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/core/extensions/spacing.dart';

class AppBarLeadingWidget extends StatelessWidget {
  const AppBarLeadingWidget({super.key, required this.unreadChatsNum});

  final int unreadChatsNum;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.router.back(),
      child: Row(
        children: [
          context.horizontalSpace(3),
          const SizedBox(
            width: 30,
            child: Icon(Icons.arrow_back_ios_new_rounded, size: 22),
          ),
          if (unreadChatsNum > 0)
            Text(
              unreadChatsNum.toString(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
        ],
      ),
    );
  }
}
