import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/functions/date_format.dart';
import 'package:whatsapp_assessment/core/helpers/extensions.dart';
import 'package:whatsapp_assessment/features/updates/data/models/status_model.dart';
import 'package:whatsapp_assessment/features/updates/presentation/manager/status_cubit/status_cubit.dart';

class StoryViewerScreen extends StatefulWidget {
  final int initialIndex;

  const StoryViewerScreen({super.key, this.initialIndex = 0});

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _progressController;
  late AnimationController _dismissController;

  Timer? _timer;
  int _currentPersonIndex = 0;
  int _currentStoryIndex = 0;
  bool isPaused = false;
  bool _isTransitioning = false;

  double _dragOffset = 0.0;

  Animation<double>? dragAnimation;
  VoidCallback? _dragAnimationListener;

  @override
  void initState() {
    super.initState();
    _currentPersonIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentPersonIndex);
    _progressController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _dismissController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _startStoryTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _progressController.dispose();
    _dismissController.dispose();
    super.dispose();
  }

  void _startStoryTimer() {
    if (_isTransitioning) return;
    _progressController.reset();
    _progressController.forward();
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 5), () {
      _nextStory();
    });
  }

  void _nextStory() {
    if (_isTransitioning) return;
    final currentPerson = context
        .read<StatusCubit>()
        .statusList[_currentPersonIndex];
    if (_currentStoryIndex < currentPerson.stories.length - 1) {
      setState(() {
        _currentStoryIndex++;
      });
      _startStoryTimer();
    } else {
      if (_currentPersonIndex <
          context.read<StatusCubit>().statusList.length - 1) {
        _isTransitioning = true;
        _timer?.cancel();
        _progressController.stop();
        setState(() {
          _currentPersonIndex++;
          _currentStoryIndex = 0;
        });
        _pageController
            .nextPage(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOutCubic,
            )
            .then((_) {
              if (!mounted) return;
              _isTransitioning = false;
              // NOW start the timer after animation is complete
              _startStoryTimer();
            });
      } else {
        _exitViewer();
      }
    }
  }

  void _previousStory() {
    if (_isTransitioning) return;
    if (_currentStoryIndex > 0) {
      setState(() {
        _currentStoryIndex--;
      });
      _startStoryTimer();
    } else {
      if (_currentPersonIndex > 0) {
        _isTransitioning = true;
        _timer?.cancel();
        _progressController.stop();

        final previousPersonIndex = _currentPersonIndex - 1;
        final previousPersonLastStory =
            context
                .read<StatusCubit>()
                .statusList[previousPersonIndex]
                .stories
                .length -
            1;
        setState(() {
          _currentPersonIndex = previousPersonIndex;
          _currentStoryIndex = previousPersonLastStory;
        });
        _pageController
            .previousPage(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOutCubic,
            )
            .then((_) {
              if (!mounted) return;
              _isTransitioning = false;
              _startStoryTimer();
            });
      }
    }
  }

  void _pauseStory() {
    setState(() {
      isPaused = true;
    });
    _timer?.cancel();
    _progressController.stop();
  }

  void _resumeStory() {
    if (_isTransitioning) return;

    setState(() {
      isPaused = false;
    });

    final remainingDuration = Duration(
      milliseconds: (5000 * (1 - _progressController.value)).round(),
    );

    _progressController.forward();

    _timer?.cancel();
    _timer = Timer(remainingDuration, () {
      _nextStory();
    });
  }

  void _exitViewer() {
    context.pop();
  }

  void _animateDragTo(double target) {
    _dragAnimationListener?.call();
    _dragAnimationListener = null;
    dragAnimation =
        Tween<double>(begin: _dragOffset, end: target).animate(
          CurvedAnimation(parent: _dismissController, curve: Curves.easeOut),
        )..addListener(() {
          setState(() {
            _dragOffset = dragAnimation!.value;
          });
        });

    _dismissController
      ..value = 0.0
      ..forward().then((_) {
        // animation complete
        // if target is off-screen, close viewer
        if (!mounted) return;
        final screenHeight = MediaQuery.of(context).size.height;
        if ((target - screenHeight).abs() < 1.0) {
          _exitViewer();
        } else {
          // reset drag offset to 0 if cancelled
          setState(() {
            _dragOffset = 0.0;
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) => _pauseStory(),
        onTapUp: (details) {
          _resumeStory();
          final screenWidth = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx < screenWidth / 2) {
            _previousStory();
          } else {
            _nextStory();
          }
        },
        onLongPressStart: (details) => _pauseStory(),
        onLongPressEnd: (details) => _resumeStory(),
        onVerticalDragStart: (details) {
          _pauseStory();
        },
        onVerticalDragUpdate: (details) {
          setState(() {
            _dragOffset += details.delta.dy;
            if (_dragOffset < 0) _dragOffset = 0;
          });
        },
        onVerticalDragEnd: (details) {
          final velocity = details.primaryVelocity ?? 0.0;

          final shouldDismiss =
              velocity > 700 || _dragOffset > screenHeight * 0.25;

          if (shouldDismiss) {
            _animateDragTo(screenHeight);
          } else {
            _animateDragTo(0.0);
             Future.delayed(const Duration(milliseconds: 320), () {
              if (mounted) _resumeStory();
            });
          }
        },

        child: Transform.translate(
          offset: Offset(0, _dragOffset),
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  // Only handle user swipes, not programmatic changes
                  if (!_isTransitioning && index != _currentPersonIndex) {
                    setState(() {
                      _currentPersonIndex = index;
                      _currentStoryIndex = 0;
                    });
                    _startStoryTimer();
                  }
                },
                itemCount: context.read<StatusCubit>().statusList.length,
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double value = 1.0;
                      double rotationValue = 0.0;

                      if (_pageController.position.haveDimensions) {
                        value = _pageController.page! - index;
                        rotationValue = value * math.pi / 6;
                        value = (1 - (value.abs() * 0.3)).clamp(0.5, 1.0);
                      }

                      return Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(rotationValue),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  0.3 * (1 - value),
                                ),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: _buildStoryContent(
                            context.read<StatusCubit>().statusList[index],
                            index,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              _buildProgressBars(),
              _buildUserInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoryContent(StatusModel story, int personIndex) {
    // Use the correct story index: current story index if this is the current person,
    // otherwise use the first story (index 0) for other people
    final storyIndex = personIndex == _currentPersonIndex
        ? _currentStoryIndex
        : 0;

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Blurred background image
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Image.network(
              story.stories[storyIndex],
              fit:
                  BoxFit.cover, // Changed to cover for better background effect
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[800],
                  child: const Center(
                    child: Icon(Icons.error, color: Colors.white, size: 50),
                  ),
                );
              },
            ),
          ),
          Container(color: Colors.grey.shade900.withOpacity(0.7)),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              story.stories[storyIndex],
              fit: BoxFit.fitWidth,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.error, color: Colors.white, size: 50),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBars() {
    final currentPerson = context
        .read<StatusCubit>()
        .statusList[_currentPersonIndex];

    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 10,
      right: 10,
      child: Row(
        children: List.generate(
          currentPerson.stories.length,
          (index) => Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              height: 3,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
              child: AnimatedBuilder(
                animation: _progressController,
                builder: (context, child) {
                  double progress = 0.0;

                  // Don't show progress during transitions
                  if (!_isTransitioning) {
                    if (index < _currentStoryIndex) {
                      progress = 1.0;
                    } else if (index == _currentStoryIndex) {
                      progress = _progressController.value;
                    }
                  } else {
                    // During transition, show completed stories but not current progress
                    if (index < _currentStoryIndex) {
                      progress = 1.0;
                    }
                  }
                  return FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    final currentStory = context
        .read<StatusCubit>()
        .statusList[_currentPersonIndex];
    return Positioned(
      top: MediaQuery.of(context).padding.top + 30,
      left: 0,
      right: 15,
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(currentStory.sender.image),
            backgroundColor: Colors.grey,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentStory.sender.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  getRelativeTime(currentStory.timestamp),
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
