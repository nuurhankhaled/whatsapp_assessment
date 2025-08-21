import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/features/conversation/presentation/controllers/message_animated_controller.dart';
import 'package:whatsapp_assessment/features/conversation/presentation/widgets/message_list_view_widget.dart';
import 'package:whatsapp_assessment/generated/assets.gen.dart';

class ConversationBody extends StatelessWidget {
  final ScrollController scrollController;
  final MessageAnimationController animationController;

  const ConversationBody({
    super.key,
    required this.scrollController,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.chatLightBackground.path),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: MessagesListView(
            scrollController: scrollController,
            animationController: animationController,
          ),
        ),
      ),
    );
  }
}
