import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/enum/message_status_enum.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/features/conversation/data/models/conversation_model.dart';
import 'package:whatsapp_assessment/features/conversation/enum/message_types_enum.dart';
import 'package:whatsapp_assessment/features/conversation/presentation/manager/conversation_cubit/convo_list.dart';
import 'package:whatsapp_assessment/features/home/presentation/manager/change_theme_cubit/change_theme_cubit.dart';
part 'conversation_state.dart';

class ConversationCubit extends Cubit<ConversationState> {
  ConversationCubit() : super(ConversationInitial());

  static ConversationCubit get(BuildContext context) =>
      BlocProvider.of<ConversationCubit>(context);

  ConversationModel? currentConversation;

  void setCurrentUser(String user) {
    currentConversation = fakeConversationData.firstWhere(
      (conversation) => conversation.sender.name == user,
    );
    emit(ConversationLoaded());
  }

  void sendMessage(String messageText) {
    if (currentConversation == null || messageText.trim().isEmpty) return;

    // Create new message
    final newMessage = MessageModel(
      currentConversation!.messages.length + 1,
      MessageType.text,
      messageText.trim(),
      null,
      true,
      getCurrentTime24H(),
      MessageStatusEnum.seen,
    );

    // First emit the message sending state for animation
    emit(MessageSending(newMessage));

    // Add message to conversation immediately (don't wait)
    currentConversation!.messages.add(newMessage);

    // Then emit the updated conversation state after a short delay
    Future.delayed(const Duration(milliseconds: 600), () {
      emit(ConversationUpdated());
    });
  }

  String getCurrentTime24H() {
    final now = DateTime.now();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    return '$hour:$minute'; // 24-hour format: HH:MM
  }

  Color getMessageBubbleColor(MessageModel message, BuildContext context) {
    if (message.isSender) {
      return !context.read<ChangeThemeCubit>().isDark
          ? AppColors.chatBubbleSender
          : AppColors.chatBubbleDarkSender;
    } else {
      return !context.read<ChangeThemeCubit>().isDark
          ? Colors.white
          : AppColors.chatBubbleDarkReciever;
    }
  }

  bool shouldAddSpacingAbove(int index) {
    if (currentConversation == null || index == 0) {
      return false;
    }

    final currentMessage = currentConversation!.messages[index];
    final previousMessage = currentConversation!.messages[index - 1];

    return currentMessage.isSender != previousMessage.isSender;
  }

  bool shouldShowTail(int index) {
    if (currentConversation == null || currentConversation!.messages.isEmpty) {
      return true;
    }

    final currentMessage = currentConversation!.messages[index];

    if (index == currentConversation!.messages.length - 1) {
      return true;
    }

    final nextMessage = currentConversation!.messages[index + 1];
    return currentMessage.isSender != nextMessage.isSender;
  }

  bool _isTextFieldFocused = false;
  bool _hasText = false;
  String _animatingText = '';

  // Getters
  bool get isTextFieldFocused => _isTextFieldFocused;
  bool get hasText => _hasText;
  String get animatingText => _animatingText;

  // UI state methods
  void updateTextFieldFocus(bool isFocused) {
    _isTextFieldFocused = isFocused;
    emit(
      ConversationUIUpdated(
        isTextFieldFocused: _isTextFieldFocused,
        hasText: _hasText,
        animatingText: _animatingText,
      ),
    );
  }

  void updateTextContent(String text) {
    _hasText = text.trim().isNotEmpty;
    emit(
      ConversationUIUpdated(
        isTextFieldFocused: _isTextFieldFocused,
        hasText: _hasText,
        animatingText: _animatingText,
      ),
    );
  }

  void startMessageAnimation(String text) {
    _animatingText = text;
    emit(
      ConversationUIUpdated(
        isTextFieldFocused: _isTextFieldFocused,
        hasText: _hasText,
        animatingText: _animatingText,
      ),
    );
  }

  void resetMessageAnimation() {
    _animatingText = '';
    emit(
      ConversationUIUpdated(
        isTextFieldFocused: _isTextFieldFocused,
        hasText: _hasText,
        animatingText: _animatingText,
      ),
    );
  }

  Future<void> sendMessageWithAnimation(String text) async {
    if (text.trim().isEmpty) return;

    // Start animation
    startMessageAnimation(text);

    // Wait for animation duration
    await Future.delayed(const Duration(milliseconds: 400));

    // Send actual message
    sendMessage(text);

    // Reset animation
    resetMessageAnimation();
  }
}
