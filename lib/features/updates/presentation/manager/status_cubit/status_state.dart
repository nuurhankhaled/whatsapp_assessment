part of 'status_cubit.dart';

abstract class StatusState extends Equatable {
  const StatusState();

  @override
  List<Object> get props => [];
}

class StatusInitial extends StatusState {}

class StoryViewerUpdated extends StatusState {
  final int personIndex;
  final int storyIndex;
  final bool isPaused;
  final bool isTransitioning;

  const StoryViewerUpdated({
    required this.personIndex,
    required this.storyIndex,
    required this.isPaused,
    required this.isTransitioning,
  });

  @override
  List<Object> get props => [personIndex, storyIndex, isPaused, isTransitioning];
}
