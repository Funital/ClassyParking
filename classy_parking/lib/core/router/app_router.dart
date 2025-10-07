import 'package:classy_parking/core/router/route_path.dart';
import 'package:classy_parking/presentation/screens/agree/agree_screen.dart';
import 'package:classy_parking/presentation/screens/alarm/alarm_screen.dart';
import 'package:classy_parking/presentation/screens/bill/bill_screen.dart';
import 'package:classy_parking/presentation/screens/home/info/info_screen.dart';
import 'package:classy_parking/presentation/screens/home/video/video_screen.dart';
import 'package:classy_parking/presentation/screens/login/login_screen.dart';
import 'package:classy_parking/presentation/screens/login/splash_screen.dart';
import 'package:classy_parking/presentation/screens/map/map_screen.dart';
import 'package:classy_parking/presentation/screens/my_page/my_page_screen.dart';
import 'package:classy_parking/presentation/screens/parking/parking_screen.dart';
import 'package:classy_parking/presentation/screens/parking_payment/parking_payment_screen.dart';
import 'package:classy_parking/presentation/screens/parking_payment/success/payment_success_screen.dart';
import 'package:classy_parking/presentation/screens/report/report_screen.dart';
import 'package:classy_parking/presentation/screens/report/report_success_screen.dart';
import 'package:classy_parking/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/car/car_screen.dart';
import '../../presentation/screens/car/photo_screen.dart';
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
  RoutePath.splash: (context, state) => const SplashScreen(),
  RoutePath.login: (context, state) => const LoginScreen(),
  RoutePath.agree: (context, state) => const AgreeScreen(),
  RoutePath.signup: (context, state) => const SignUpScreen(),
  RoutePath.car: (context, state) => const CarScreen(),
  RoutePath.photo: (context, state) => const PhotoScreen(),
  RoutePath.home: (context, state) => const MainScreen(),
  RoutePath.myPage: (context, state) => const MyPageScreen(),
  RoutePath.home_video: (context, state) => const VideoScreen(),
  RoutePath.home_info: (context, state) => const InfoScreen(),
  RoutePath.bill: (context, state) => const BillScreen(),
  RoutePath.map: (context, state) => const MapScreen(),
  RoutePath.report: (context, state) => const ReportScreen(),
  RoutePath.report_success: (context, state) => const ReportSuccessScreen(),
  RoutePath.parking: (context, state) => const ParkingScreen(),
  RoutePath.payment: (context, state) => const ParkingPaymentScreen(),
  RoutePath.success_payment: (context, state) => const PaymentSuccessScreen(),
  RoutePath.alarm: (context, state) => const AlarmScreen(),
};

// 앱바 고정 경로 목록 -> 여기 적으면 앱바 고정됨.
final List<String> shellRoutes = [
  RoutePath.home,
  RoutePath.map,
  RoutePath.myPage
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
          .map((path) {
        // pageBuilder로 전환
        return GoRoute(
          path: path,
          pageBuilder: (context, state) {
            final builder = routeBuilders[path]!;
            if (path == RoutePath.home) {
              // 홈화면은 애니메이션 제거
              return const NoTransitionPage(child: MainScreen());
            }
            return MaterialPage(child: builder(context, state));
          },
        );
      }),

      // 앱바 고정 ShellRoute
      ShellRoute(
        builder: (context, state, child) => ScaffoldWithNavBar(child: child),
        routes: shellRoutes.map((path) {
          return GoRoute(
            path: path,
            pageBuilder: (context, state) {
              final builder = routeBuilders[path]!;
              if (path == RoutePath.home) {
                // ShellRoute 내부에서도 애니메이션 제거
                return const NoTransitionPage(child: MainScreen());
              }
              return MaterialPage(child: builder(context, state));
            },
          );
        }).toList(),
      ),
    ],
  );
}
