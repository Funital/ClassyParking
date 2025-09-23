import 'package:classy_parking/core/router/route_path.dart';
import 'package:classy_parking/presentation/screens/bill/bill_screen.dart';
import 'package:classy_parking/presentation/screens/home/info/info_screen.dart';
import 'package:classy_parking/presentation/screens/home/video/video_screen.dart';
import 'package:classy_parking/presentation/screens/my_page/my_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/main/main_screen.dart';
import '../../presentation/widgets/custom_app_bar.dart';

// 앱바 고정 UI 레퍼
class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;
  const ScaffoldWithNavBar({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(), body: child);
  }
}

// 경로별 화면 빌더 매핑 -> 여기 작성 필수!
final Map<String, GoRouterWidgetBuilder> routeBuilders = {
  RoutePath.home: (context, state) => const MainScreen(),
  RoutePath.myPage: (context, state) => const MyPageScreen(),
  RoutePath.home_video: (context, state) => const VideoScreen(),
  RoutePath.home_info: (context, state) => const InfoScreen(),
  RoutePath.bill: (context, state) => const BillScreen(),
};

// 앱바 고정 경로 목록 -> 여기 적으면 앱바 고정됨.
final List<String> shellRoutes = [
  RoutePath.home,
  // RoutePath.albumAdd,
  // 필요시 추가

];

// GoRouter
GoRouter createAppRouter(String initialRoute) {
  return GoRouter(
    initialLocation: initialRoute,
    routes: [
      // 앱바 없는 개별 라우트들
      ...routeBuilders.keys
          .where((path) => !shellRoutes.contains(path))
          .map((path) => GoRoute(path: path, builder: routeBuilders[path]!)),

      // 앱바 고정 ShellRoute
      ShellRoute(
        builder: (context, state, child) => ScaffoldWithNavBar(child: child),
        routes: shellRoutes.map((path) {
          return GoRoute(path: path, builder: routeBuilders[path]!);
        }).toList(),
      ),
    ],
  );
}
