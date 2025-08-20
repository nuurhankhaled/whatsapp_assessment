import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/features/updates/data/models/story_viewer_configurations.dart';

class StoryGestureHelper {
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final Function(double) onDragUpdate;
  final Function(double, double) onDragEnd;

  StoryGestureHelper({
    required this.onPause,
    required this.onResume,
    required this.onPrevious,
    required this.onNext,
    required this.onDragUpdate,
    required this.onDragEnd,
  });

  void handleTapDown(TapDownDetails details) {
    onPause();
  }

  void handleTapUp(TapUpDetails details, double screenWidth) {
    onResume();
    if (details.globalPosition.dx < screenWidth / 2) {
      onPrevious();
    } else {
      onNext();
    }
  }

  void handleLongPressStart(LongPressStartDetails details) {
    onPause();
  }

  void handleLongPressEnd(LongPressEndDetails details) {
    onResume();
  }

  void handleVerticalDragStart(DragStartDetails details) {
    onPause();
  }

  void handleVerticalDragUpdate(DragUpdateDetails details, double currentOffset) {
    final newOffset = currentOffset + details.delta.dy;
    onDragUpdate(newOffset < 0 ? 0 : newOffset);
  }

  void handleVerticalDragEnd(DragEndDetails details, double dragOffset, double screenHeight) {
    final velocity = details.primaryVelocity ?? 0.0;
    final shouldDismiss = velocity > StoryViewerConfig.dismissVelocityThreshold ||
        dragOffset > screenHeight * StoryViewerConfig.dismissThreshold;

    if (shouldDismiss) {
      onDragEnd(screenHeight, dragOffset);
    } else {
      onDragEnd(0.0, dragOffset);
    }
  }
}