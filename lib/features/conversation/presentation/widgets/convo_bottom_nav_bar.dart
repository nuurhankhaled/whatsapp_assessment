import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/features/conversation/presentation/manager/conversation_cubit/conversation_cubit.dart';
import 'package:whatsapp_assessment/features/conversation/presentation/widgets/actions_buttons.dart';
import 'package:whatsapp_assessment/features/conversation/presentation/widgets/message_input_field.dart';
import 'package:whatsapp_assessment/generated/assets.gen.dart';

class ConvoBottomNavBar extends StatefulWidget {
  const ConvoBottomNavBar({super.key});

  @override
  State<ConvoBottomNavBar> createState() => _ConvoBottomNavBarState();
}

class _ConvoBottomNavBarState extends State<ConvoBottomNavBar>
    with TickerProviderStateMixin {
  final FocusNode _textFieldFocus = FocusNode();
  final TextEditingController _textController = TextEditingController();

  late AnimationController _textAnimationController;
  late Animation<double> _textOpacityAnimation;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _setupListeners();
  }

  void _initializeAnimations() {
    _textAnimationController = AnimationController(
      duration: const Duration(
        milliseconds: 400,
      ), // Match with bubble animation timing
      vsync: this,
    );

    _textOpacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _textAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _textSlideAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(1.5, -0.7)).animate(
          CurvedAnimation(
            parent: _textAnimationController,
            curve: Curves.easeInOut,
          ),
        );
  }

  void _setupListeners() {
    _textFieldFocus.addListener(() {
      context.read<ConversationCubit>().updateTextFieldFocus(
        _textFieldFocus.hasFocus,
      );
    });

    _textController.addListener(() {
      context.read<ConversationCubit>().updateTextContent(_textController.text);
    });
  }

  @override
  void dispose() {
    _textAnimationController.dispose();
    _textFieldFocus.dispose();
    _textController.dispose();
    super.dispose();
  }

  Future _sendMessage() async {
    if (_textController.text.trim().isEmpty) return;

    final messageText = _textController.text.trim();

    // Start text field animation
    context.read<ConversationCubit>().startMessageAnimation(messageText);
    _textController.clear();

    // Start BOTH animations simultaneously
    final textFieldAnimation = _textAnimationController.forward();

    // Send message immediately to show bubble animation
    context.read<ConversationCubit>().sendMessage(messageText);

    // Wait for text field animation to complete
    await textFieldAnimation;

    // Reset text field animation
    _textAnimationController.reset();
    context.read<ConversationCubit>().resetMessageAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationCubit, ConversationState>(
      builder: (context, state) {
        final cubit = context.read<ConversationCubit>();
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        return AnimatedContainer(
          duration: Duration.zero,
          padding: EdgeInsets.only(bottom: keyboardHeight),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            width: double.infinity,
            height: cubit.isTextFieldFocused ? 50 : 77,
            color: AppColors.conversationBarsLightBackground.withAlpha(220),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    Assets.images.convoPlusIcon.path,
                    width: 27,
                  ),
                ),
                MessageInputField(
                  controller: _textController,
                  focusNode: _textFieldFocus,
                  isTextFieldFocused: cubit.isTextFieldFocused,
                  animatingText: cubit.animatingText,
                  animationController: _textAnimationController,
                  opacityAnimation: _textOpacityAnimation,
                  slideAnimation: _textSlideAnimation,
                ),
                ActionButtons(onSendTap: _sendMessage),
              ],
            ),
          ),
        );
      },
    );
  }
}
