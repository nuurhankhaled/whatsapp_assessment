part of 'conversation_cubit.dart';

abstract class ConversationState extends Equatable {
  const ConversationState();

  @override
  List<Object?> get props => [];
}

class ConversationInitial extends ConversationState {}

class ConversationLoaded extends ConversationState {}

class ConversationUpdated extends ConversationState {}

class MessageSending extends ConversationState {
  final MessageModel message;

  const MessageSending(this.message);

  @override
  List<Object?> get props => [message];
}

class ConversationUIUpdated extends ConversationState {
  final bool isTextFieldFocused;
  final bool hasText;
  final String animatingText;

  const ConversationUIUpdated({
    required this.isTextFieldFocused,
    required this.hasText,
    required this.animatingText,
  });

  @override
  List<Object> get props => [isTextFieldFocused, hasText, animatingText];
}
