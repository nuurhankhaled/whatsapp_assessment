import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/features/chats/data/models/chat_model.dart';
import 'package:whatsapp_assessment/generated/assets.gen.dart';

class AppBarTitleWidget extends StatelessWidget {
  const AppBarTitleWidget({super.key, required this.sender});
  final Sender sender;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.primaryColor.withAlpha(100),
          radius: 18,
          backgroundImage: NetworkImage(sender.image),
        ),
        Text(sender.name, style: Theme.of(context).textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.bold
        )),
        const Spacer(),
        Image.asset(Assets.images.convoVideoIcon.path, width: 27,),
        Image.asset(Assets.images.convoPhoneIcon.path, width: 27,),
      ],
    );
  }
}
