import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/features/conversation/presentation/manager/conversation_cubit/conversation_cubit.dart';
import 'package:whatsapp_assessment/features/home/presentation/manager/change_theme_cubit/change_theme_cubit.dart';
import 'package:whatsapp_assessment/generated/assets.gen.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onSendTap;

  const ActionButtons({super.key, required this.onSendTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationCubit, ConversationState>(
      builder: (context, state) {
        final cubit = context.read<ConversationCubit>();
        final hasText = cubit.hasText;
        final isTextFieldFocused = cubit.isTextFieldFocused;

        return Row(
          children: [
            if (!hasText) _buildCameraButton(isTextFieldFocused, context),
            _buildSendMicButton(hasText, isTextFieldFocused, context),
          ],
        );
      },
    );
  }

  Widget _buildCameraButton(bool isTextFieldFocused, BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      padding: EdgeInsets.only(left: 16.0, top: isTextFieldFocused ? 10 : 12),
      child: GestureDetector(
        onTap: () {},
        child: Image.asset(
          Assets.images.convoCamera.path,
          width: 27,
          color: context.read<ChangeThemeCubit>().isDark
              ? Colors.white
              : Colors.black,
        ),
      ),
    );
  }

  Widget _buildSendMicButton(
    bool hasText,
    bool isTextFieldFocused,
    BuildContext context,
  ) {
    return AnimatedPadding(
      duration: Duration.zero,
      curve: Curves.easeInOut,
      padding: EdgeInsets.only(
        left: hasText ? 16.0 : 8.0,
        top: isTextFieldFocused ? 12 : 12,
        right: 12,
      ),
      child: GestureDetector(
        onTap: hasText ? onSendTap : () {},
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200), // Add smooth transition
          child: hasText
              ? Image.asset(
                  Assets.images.sendButton.path,
                  key: const ValueKey('send'),
                  width: 27,
                )
              : Image.asset(
                  Assets.images.mic.path,
                  key: const ValueKey('mic'),
                  width: 27,
                  color: context.read<ChangeThemeCubit>().isDark
                      ? Colors.white
                      : Colors.black,
                ),
        ),
      ),
    );
  }
}
