import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/features/chats/data/models/chat_model.dart';
import 'package:whatsapp_assessment/features/conversation/presentation/widgets/app_bar_leading_widget.dart';
import 'package:whatsapp_assessment/features/conversation/presentation/widgets/app_bar_title_widget.dart';
import 'package:whatsapp_assessment/features/conversation/presentation/widgets/convo_bottom_nav_bar.dart';
import 'package:whatsapp_assessment/features/conversation/presentation/widgets/message_bubble.dart';
import 'package:whatsapp_assessment/generated/assets.gen.dart';

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

class _ConversationPageState extends State<ConversationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 53,
        leading: AppBarLeadingWidget(unreadChatsNum: widget.unreadChatsNum),
        title: AppBarTitleWidget(sender: widget.sender),
        backgroundColor: AppColors.conversationBarsLightBackground.withAlpha(
          220,
        ),
        elevation: 0,
      ),
      bottomNavigationBar: const ConvoBottomNavBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.images.chatLightBackground.path),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children:const [
                MessageBubble(
                  
                  text: "Good, I'll see yseou tonight. Don't forget, now, 1:15 a.m., Twin Pines Mall.",
                  color: Colors.white,
                  tail: true,
                  
                  isSender: false,
                ),
                // Add some spacing
                  SizedBox(height: 8),
               
                MessageBubble(
                                    seen: true,

                  text: "Yeah, I'll keep that in mind....",
                  color: const Color(0xFFDCF8C6), // WhatsApp green
                  tail: true,
                
                  isSender: true,
                ),
                // Time stamp and read receipt for sent message
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}