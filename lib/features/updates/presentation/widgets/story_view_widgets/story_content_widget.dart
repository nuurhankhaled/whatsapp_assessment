import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/features/updates/data/models/status_model.dart';
import 'package:whatsapp_assessment/features/updates/presentation/manager/status_cubit/status_cubit.dart';

class StoryContentWidget extends StatelessWidget {
  final StatusModel story;
  final int personIndex;

  const StoryContentWidget({
    super.key,
    required this.story,
    required this.personIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusCubit, StatusState>(
      buildWhen: (previous, current) {
        if (current is StoryViewerUpdated) {
          final cubit = context.read<StatusCubit>();
          return personIndex == cubit.currentPersonIndex;
        }
        return false;
      },
      builder: (context, state) {
        final cubit = context.read<StatusCubit>();
        final storyIndex = personIndex == cubit.currentPersonIndex 
            ? cubit.currentStoryIndex 
            : 0;

        if (storyIndex >= story.stories.length) {
          return Container(
            color: Colors.grey[800],
            child: const Center(
              child: Icon(Icons.error, color: Colors.white, size: 50),
            ),
          );
        }

        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildBlurredBackground(story.stories[storyIndex]),
              Container(color: Colors.grey.shade900.withAlpha(172)),
              _buildMainImage(story.stories[storyIndex]),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBlurredBackground(String imageUrl) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: _buildLoadingWidget,
        errorBuilder: _buildErrorWidget,
      ),
    );
  }

  Widget _buildMainImage(String imageUrl) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Image.network(
        imageUrl,
        fit: BoxFit.fitWidth,
        loadingBuilder: _buildLoadingWidget,
        errorBuilder: _buildErrorWidget,
      ),
    );
  }

  Widget _buildLoadingWidget(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) {
    if (loadingProgress == null) return child;
    return const Center(
      child: CircularProgressIndicator(color: Colors.white),
    );
  }

  Widget _buildErrorWidget(BuildContext context, Object error, StackTrace? stackTrace) {
    return Container(
      color: Colors.grey[800],
      child: const Center(
        child: Icon(Icons.error, color: Colors.white, size: 50),
      ),
    );
  }
}