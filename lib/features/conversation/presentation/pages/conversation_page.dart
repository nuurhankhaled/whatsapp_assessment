import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/features/chats/data/models/chat_model.dart';
import 'package:whatsapp_assessment/features/conversation/presentation/controllers/message_animated_controller.dart';
import 'package:whatsapp_assessment/features/conversation/presentation/manager/conversation_cubit/conversation_cubit.dart';
import 'package:whatsapp_assessment/features/conversation/presentation/widgets/app_bar_leading_widget.dart';
import 'package:whatsapp_assessment/features/conversation/presentation/widgets/app_bar_title_widget.dart';
import 'package:whatsapp_assessment/features/conversation/presentation/widgets/conversation_body.dart';
import 'package:whatsapp_assessment/features/conversation/presentation/widgets/convo_bottom_nav_bar.dart';
import 'package:whatsapp_assessment/features/home/presentation/manager/change_theme_cubit/change_theme_cubit.dart';

@RoutePage()
class ConversationPage extends StatefulWidget {
  const ConversationPage({
    super.key,
    required this.sender,
    required this.unreadChatsNum,
  });

  final Sender sender;
  final int unreadChatsNum;

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final MessageAnimationController _messageAnimationController =
      MessageAnimationController();

  @override
  void initState() {
    super.initState();
    _messageAnimationController.initialize(this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageAnimationController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0, // Since reverse: true, 0 is bottom
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
      );
    }
  }

  void _handleMessageSending(MessageSending state) {
    _messageAnimationController.startAnimation(state.message);
  }

  void _handleConversationUpdated() {
    _messageAnimationController.resetAnimation();
    Future.delayed(const Duration(milliseconds: 50), () => _scrollToBottom());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConversationCubit, ConversationState>(
      listener: (context, state) {
        if (state is MessageSending) {
          _handleMessageSending(state);
        } else if (state is ConversationUpdated) {
          _handleConversationUpdated();
        }
      },
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leadingWidth: 53,
          leading: AppBarLeadingWidget(unreadChatsNum: widget.unreadChatsNum),
          title: AppBarTitleWidget(sender: widget.sender),
          backgroundColor: context.read<ChangeThemeCubit>().isDark
              ? Colors.black.withAlpha(230)
              : AppColors.conversationBarsLightBackground.withAlpha(220),
          elevation: 0,
        ),
        bottomNavigationBar: const ConvoBottomNavBar(),
        body: ConversationBody(
          scrollController: _scrollController,
          animationController: _messageAnimationController,
        ),
      ),
    );
  }
}
