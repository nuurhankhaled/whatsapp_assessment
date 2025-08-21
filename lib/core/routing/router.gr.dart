// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:whatsapp_assessment/features/chats/data/models/chat_model.dart'
    as _i5;
import 'package:whatsapp_assessment/features/conversation/presentation/pages/conversation_page.dart'
    as _i1;
import 'package:whatsapp_assessment/features/home/presentation/pages/home_page.dart'
    as _i2;

/// generated route for
/// [_i1.ConversationPage]
class ConversationRoute extends _i3.PageRouteInfo<ConversationRouteArgs> {
  ConversationRoute({
    _i4.Key? key,
    required _i5.Sender sender,
    required int unreadChatsNum,
    List<_i3.PageRouteInfo>? children,
  }) : super(
         ConversationRoute.name,
         args: ConversationRouteArgs(
           key: key,
           sender: sender,
           unreadChatsNum: unreadChatsNum,
         ),
         initialChildren: children,
       );

  static const String name = 'ConversationRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ConversationRouteArgs>();
      return _i1.ConversationPage(
        key: args.key,
        sender: args.sender,
        unreadChatsNum: args.unreadChatsNum,
      );
    },
  );
}

class ConversationRouteArgs {
  const ConversationRouteArgs({
    this.key,
    required this.sender,
    required this.unreadChatsNum,
  });

  final _i4.Key? key;

  final _i5.Sender sender;

  final int unreadChatsNum;

  @override
  String toString() {
    return 'ConversationRouteArgs{key: $key, sender: $sender, unreadChatsNum: $unreadChatsNum}';
  }
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute({List<_i3.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomePage();
    },
  );
}
