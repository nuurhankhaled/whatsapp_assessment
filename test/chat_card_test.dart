import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whatsapp_assessment/features/home/presentation/widgets/chat_card.dart';
import 'package:whatsapp_assessment/features/home/presentation/widgets/unread_message_badge.dart';

void main() {
  group('ChatCard', () {
    testWidgets('displays chat card with unread badge when count > 0', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ChatCard(unreadCount: 5),
          ),
        ),
      );

      expect(find.byType(ChatCard), findsOneWidget);
      expect(find.byType(UnreadMessageBadge), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
      expect(find.text('Chat Title '), findsOneWidget);
      expect(find.text('12:00PM'), findsOneWidget);
    });

    testWidgets('does not display badge when unreadCount is 0', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ChatCard(unreadCount: 0),
          ),
        ),
      );

      expect(find.byType(ChatCard), findsOneWidget);
      expect(find.byType(UnreadMessageBadge), findsOneWidget);
      expect(find.text('0'), findsNothing);
      expect(find.text('Chat Title '), findsOneWidget);
      expect(find.text('12:00PM'), findsOneWidget);
    });

    testWidgets('displays default ChatCard without badge when unreadCount not specified', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ChatCard(),
          ),
        ),
      );

      expect(find.byType(ChatCard), findsOneWidget);
      expect(find.byType(UnreadMessageBadge), findsOneWidget);
      expect(find.text('Chat Title '), findsOneWidget);
      expect(find.text('12:00PM'), findsOneWidget);
    });
  });
}