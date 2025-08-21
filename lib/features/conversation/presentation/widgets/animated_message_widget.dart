import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/features/conversation/data/models/conversation_model.dart';
import 'package:whatsapp_assessment/features/conversation/presentation/widgets/message_bubble.dart';

class AnimatedMessageBubble extends StatelessWidget {
  final MessageModel message;
  final Color color;
  final bool tail;
  final Animation<double> scaleAnimation;
  final Animation<double> opacityAnimation;
  final Animation<Offset> slideAnimation;
  final AnimationController controller;

  const AnimatedMessageBubble({
    super.key,
    required this.message,
    required this.color,
    required this.tail,
    required this.scaleAnimation,
    required this.opacityAnimation,
    required this.slideAnimation,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return SlideTransition(
          position: slideAnimation,
          child: Transform.scale(
            scale: scaleAnimation.value,
            child: Opacity(
              opacity: opacityAnimation.value,
              child: MessageBubble(
                messageModel: message,
                color: color,
                tail: tail,
              ),
            ),
          ),
        );
      },
    );
  }
}
