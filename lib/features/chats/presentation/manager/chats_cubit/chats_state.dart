part of 'chats_cubit.dart';

abstract class ChatsState extends Equatable {
  const ChatsState();

  @override
  List<Object> get props => [];
}

class ChatsInitial extends ChatsState {}

class ChatsFilterState extends ChatsState {
  final int currentIndex;

  const ChatsFilterState(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}
