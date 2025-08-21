import 'package:auto_route/auto_route.dart';
import 'package:whatsapp_assessment/core/routing/router.gr.dart';

@AutoRouterConfig()
class RootRouter extends RootStackRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(initial: true, page: HomeRoute.page),
    AutoRoute(
      page: ConversationRoute.page,
    ),
  ];
}
