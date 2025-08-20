import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/helpers/extensions.dart';
import 'package:whatsapp_assessment/features/updates/data/models/story_viewer_configurations.dart';
import 'package:whatsapp_assessment/features/updates/helpers/animations_helper.dart';
import 'package:whatsapp_assessment/features/updates/helpers/story_gesture_helper.dart';
import 'package:whatsapp_assessment/features/updates/helpers/story_helper.dart';
import 'package:whatsapp_assessment/features/updates/presentation/manager/status_cubit/status_cubit.dart';
import 'package:whatsapp_assessment/features/updates/presentation/widgets/story_view_widgets/story_page_view_widget.dart';
import 'package:whatsapp_assessment/features/updates/presentation/widgets/story_view_widgets/story_progress_widget.dart';
import 'package:whatsapp_assessment/features/updates/presentation/widgets/story_view_widgets/story_user_info_widget.dart';

class StoryViewerScreen extends StatefulWidget {
  final int initialIndex;
  const StoryViewerScreen({super.key, this.initialIndex = 0});

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late StoryAnimationHelper _animationHelper;
  late StoryGestureHelper _gestureHelper;
  late StoryHelper _storyController;
  double _dragOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    _pageController = PageController(initialPage: widget.initialIndex);
    _animationHelper = StoryAnimationHelper(this);
    _storyController = StoryHelper(
      context: context,
      animationHelper: _animationHelper,
      onExit: () => context.pop(),
      onPageTransition: _handlePageTransition,
    );
    _gestureHelper = StoryGestureHelper(
      onPause: _storyController.pauseStory,
      onResume: _storyController.resumeStory,
      onPrevious: _storyController.previousStory,
      onNext: _storyController.nextStory,
      onDragUpdate: (offset) => setState(() => _dragOffset = offset),
      onDragEnd: _handleDragEnd,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StatusCubit>().initializeStoryViewer(widget.initialIndex);
      _storyController.startStoryTimer(_storyController.nextStory);
    });
  }

  void _handlePageTransition(bool isNext) {
    context.read<StatusCubit>().cancelStoryTimer();
    _animationHelper.stopProgress();

    final transition = isNext
        ? _pageController.nextPage
        : _pageController.previousPage;
    transition(
      duration: StoryViewerConfig.pageTransitionDuration,
      curve: StoryViewerConfig.pageTransitionCurve,
    ).then((_) {
      if (!mounted) return;
      context.read<StatusCubit>().onPageTransitionComplete();
      _storyController.startStoryTimer(_storyController.nextStory);
    });
  }

  void _handleDragEnd(double target, double currentOffset) {
    _animationHelper.animateDragTo(
      target,
      currentOffset,
      () => setState(() => _dragOffset = _animationHelper.dragAnimation!.value),
      () => _onDragComplete(target),
    );
  }

  void _onDragComplete(double target) {
    if (!mounted) return;
    final screenHeight = MediaQuery.of(context).size.height;
    if ((target - screenHeight).abs() < 1.0) {
      context.pop();
    } else {
      setState(() => _dragOffset = 0.0);
      Future.delayed(StoryViewerConfig.resumeDelay, () {
        if (mounted) _storyController.resumeStory();
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationHelper.dispose();
    _storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<StatusCubit, StatusState>(
        builder: (context, state) => Transform.translate(
          offset: Offset(0, _dragOffset),
          child: GestureDetector(
            onTapDown: _gestureHelper.handleTapDown,
            onTapUp: (details) => _gestureHelper.handleTapUp(
              details,
              MediaQuery.of(context).size.width,
            ),
            onLongPressStart: _gestureHelper.handleLongPressStart,
            onLongPressEnd: _gestureHelper.handleLongPressEnd,
            onVerticalDragStart: _gestureHelper.handleVerticalDragStart,
            onVerticalDragUpdate: (details) =>
                _gestureHelper.handleVerticalDragUpdate(details, _dragOffset),
            onVerticalDragEnd: (details) =>
                _gestureHelper.handleVerticalDragEnd(
                  details,
                  _dragOffset,
                  MediaQuery.of(context).size.height,
                ),
            child: Stack(
              children: [
                StoryPageViewWidget(
                  pageController: _pageController,
                  storyController: _storyController,
                ),
                StoryProgressWidget(
                  progressController: _animationHelper.progressController,
                ),
                const StoryUserInfoWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
