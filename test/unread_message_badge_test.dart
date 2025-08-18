import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whatsapp_assessment/features/home/presentation/widgets/unread_message_badge.dart';

void main() {
  group('UnreadMessageBadge', () {
    testWidgets('shows badge when count is greater than 0', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UnreadMessageBadge(count: 5),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('does not show badge when count is 0', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UnreadMessageBadge(count: 0),
          ),
        ),
      );

      expect(find.byType(UnreadMessageBadge), findsOneWidget);
      expect(find.text('0'), findsNothing);
    });

    testWidgets('shows 999+ for counts greater than 999', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UnreadMessageBadge(count: 1500),
          ),
        ),
      );

      expect(find.text('999+'), findsOneWidget);
    });

    testWidgets('does not show badge when count is negative', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UnreadMessageBadge(count: -1),
          ),
        ),
      );

      expect(find.byType(UnreadMessageBadge), findsOneWidget);
      expect(find.text('-1'), findsNothing);
    });
  });
}