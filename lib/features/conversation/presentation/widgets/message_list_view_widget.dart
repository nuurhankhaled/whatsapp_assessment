import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/extensions/spacing.dart';
import 'package:whatsapp_assessment/features/conversation/data/models/conversation_model.dart';
import 'package:whatsapp_assessment/features/conversation/presentation/controllers/message_animated_controller.dart';
import 'package:whatsapp_assessment/features/conversation/presentation/manager/conversation_cubit/conversation_cubit.dart';
import 'package:whatsapp_assessment/features/conversation/presentation/widgets/animated_message_widget.dart';
import 'package:whatsapp_assessment/features/conversation/presentation/widgets/message_bubble.dart';

class MessagesListView extends StatelessWidget {
  final ScrollController scrollController;
  final MessageAnimationController animationController;

  const MessagesListView({
    super.key,
    required this.scrollController,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationCubit, ConversationState>(
      // Make sure to rebuild when conversation updates
      buildWhen: (previous, current) {
        return current is ConversationLoaded ||
               current is ConversationUpdated ||
               current is MessageSending;
      },
      builder: (context, state) {
        final cubit = context.read<ConversationCubit>();
        final conversation = cubit.currentConversation;

        if (conversation == null) {
          return const Center(
            child: Text(
              'No conversation found',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.all(8.0),
          reverse: true,
          itemCount: conversation.messages.length,
          itemBuilder: (context, index) => _buildMessageItem(
            context,
            index,
            conversation.messages,
            cubit,
          ),
        );
      },
    );
  }

  Widget _buildMessageItem(
    BuildContext context,
    int index,
    List<MessageModel> messages,
    ConversationCubit cubit,
  ) {
    final reversedIndex = messages.length - 1 - index;
    final message = messages[reversedIndex];
    final shouldAddSpacing = cubit.shouldAddSpacingAbove(reversedIndex);
    final isAnimating = animationController.animatingMessage?.id == message.id;

    return Column(
      children: [
        if (shouldAddSpacing && !isAnimating) context.verticalSpace(4),
        _buildMessage(context, message, reversedIndex, isAnimating, cubit),
      ],
    );
  }

  Widget _buildMessage(
    BuildContext context,
    MessageModel message,
    int reversedIndex,
    bool isAnimating,
    ConversationCubit cubit,
  ) {
    final color = cubit.getMessageBubbleColor(message);
    final tail = cubit.shouldShowTail(reversedIndex);

    if (isAnimating) {
      return AnimatedMessageBubble(
        message: message,
        color: color,
        tail: tail,
        scaleAnimation: animationController.scaleAnimation,
        opacityAnimation: animationController.opacityAnimation,
        slideAnimation: animationController.slideAnimation,
        controller: animationController.controller,
      );
    }

    return MessageBubble(
      messageModel: message,
      color: color,
      tail: tail,
    );
  }
}
