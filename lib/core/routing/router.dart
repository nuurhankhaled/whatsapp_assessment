import 'package:auto_route/auto_route.dart';
import 'package:whatsapp_assessment/core/routing/router.gr.dart';

@AutoRouterConfig()
class RootRouter extends RootStackRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(initial: true, page: HomeRoute.page),
    // AutoRoute(
    //   page: ProfileInfoRoute.page,
    // ),
    // AutoRoute(
    //   page: HomeRoute.page,
    //   guards: [
    //     AuthGuard(),
    //     EmulatorsGuard(),
    //     JailbreakRootGuard(),
    //   ],
    // ),
    // AutoRoute(
    //   page: StoreRoute.page,
    // ),
    // AutoRoute(
    //   page: OrderCheckoutRoute.page,
    // ),
    // AutoRoute(
    //   page: OrderConfirmedRoute.page,
    // ),
    // AutoRoute(
    //   page: SignInRoute.page,
    // ),
    // AutoRoute(
    //   page: CodeRegistrationRoute.page,
    // ),
    // AutoRoute(
    //   page: SignUpRoute.page,
    // ),
    // AutoRoute(
    //   page: SuccessfulRegistrationRoute.page,
    // ),
    // AutoRoute(
    //   page: AccessDeniedRoute.page,
    // ),
    // AutoRoute(
    //   page: NotificationsRoute.page,
    // ),
    // AutoRoute(
    //   page: CentersRoute.page,
    // ),
    // AutoRoute(
    //   page: ExplanatoryVideoRoute.page,
    // ),
  ];
}
