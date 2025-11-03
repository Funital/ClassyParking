// import 'dart:ui';
//
// import 'package:classy_parking/core/constants/font.dart';
// import 'package:classy_parking/presentation/widgets/custom_sub_app_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../widgets/traffic_light.dart';
// import 'my_page_view_model.dart';
//
// class MyPageScreen extends StatelessWidget {
//   const MyPageScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: ChangeNotifierProvider(
//           create: (_) => MyPageViewModel(),
//           child: Consumer<MyPageViewModel>(
//             builder: (context, viewModel, _) {
//               final model = viewModel.myPageModel;
//               return SingleChildScrollView(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 20),
//
//                     // 프로필 및 주차 상태
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             showDialog(
//                               context: context,
//                               barrierColor: Colors.transparent,
//                               builder: (context) {
//                                 return GestureDetector(
//                                   onTap: () => Navigator.of(context).pop(),
//                                   child: BackdropFilter(
//                                     filter:
//                                     ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//                                     child: Container(
//                                       color: Colors.white.withValues(alpha: 0.8),
//                                       child: Center(
//                                         child: Dialog(
//                                           backgroundColor: Colors.transparent,
//                                           child: InteractiveViewer(
//                                             child: ClipRRect(
//                                               borderRadius:
//                                               BorderRadius.circular(12),
//                                               child: Image.asset(
//                                                 'assets/images/profile.png',
//                                                 fit: BoxFit.contain,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                           child: Container(
//                             width: 150,
//                             height: 150,
//                             decoration: BoxDecoration(
//                               color: Colors.grey[300],
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(12),
//                               child: Image.asset(
//                                 'assets/images/profile.png',
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 24),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             TrafficLight(
//                               redColor: Colors.grey,
//                               yellowColor: Colors.grey,
//                               greenColor: Colors.green,
//                               radius: 25,
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 4, horizontal: 4),
//                             ),
//                             const SizedBox(height: 8),
//                             const Text(
//                               '내 주차자리 상태',
//                               style:
//                               TextStyle(color: Colors.grey, fontSize: 12),
//                             ),
//                             const SizedBox(height: 4),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 10,
//                                   height: 10,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: model.parkingStatus == '사용가능'
//                                         ? Colors.green
//                                         : Colors.red,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Text(
//                                   model.parkingStatus,
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(height: 20),
//
//                     // 정보 카드
//                     Container(
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withValues(alpha: 0.3),
//                             blurRadius: 8,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           _infoRow('닉네임', model.nickname),
//                           _infoRow('전화번호', model.phoneNumber),
//                           _infoRow('차종', model.carType),
//                           _infoRow('차 이름', model.carName),
//                           _infoRow('차 번호', model.carNumber),
//                           const SizedBox(height: 20),
//                           _licenseButton(model.isLicenseUploaded),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _infoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 100,
//             child: Text(
//               label,
//               style: AppFont.size16.copyWith(
//                 fontWeight: FontWeight.w700,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: AppFont.size16.copyWith(
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _licenseButton(bool isUploaded) {
//     return SizedBox(
//       width: double.infinity,
//       height: 50,
//       child: ElevatedButton.icon(
//         onPressed: () {
//           // TODO: 업로드 동작 연결
//         },
//         label: Text(
//           isUploaded ? "운전면허증 업로드 완료" : "운전면허증 업로드 필요",
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//             fontSize: 16,
//           ),
//         ),
//         icon: Icon(
//           isUploaded ? Icons.check_circle : Icons.upload_file,
//           color: Colors.white,
//         ),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: isUploaded ? Colors.blue : Colors.grey,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),
//     );
//   }
// }

// lib/screens/my_page_screen.dart

import 'package:classy_parking/core/router/route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'info/mypage_info_screen.dart';
import 'my_page_view_model.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyPageViewModel(),
      child: Consumer<MyPageViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            // appBar: AppBar(
            //   // 앱 바를 비우거나 제목을 추가하여 깔끔하게 처리
            //   automaticallyImplyLeading: false, // 뒤로가기 버튼 자동 생성 방지
            //   backgroundColor: Colors.white,
            //   elevation: 0,
            // ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  _buildHeader(viewModel),
                  const SizedBox(height: 30),
                  _buildPushNotificationSetting(viewModel),
                  const Divider(height: 1),
                  _buildMenuList(context, viewModel),
                  const SizedBox(height: 30),
                  _buildFooter(viewModel),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // 1. 헤더 (사용자 프로필 및 닉네임)
  Widget _buildHeader(MyPageViewModel viewModel) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, size: 50, color: Colors.white),
        ),
        const SizedBox(height: 10),
        Text(
          viewModel.model.nickname,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // 2. 푸시 알림 설정
  Widget _buildPushNotificationSetting(MyPageViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "푸시 알림 설정",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                "매일 오전 11시에 알림을 보내드려요",
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ],
          ),
          Switch.adaptive(
            value: viewModel.model.isPushNotificationEnabled,
            onChanged: viewModel.togglePushNotification,
            activeColor: Colors.teal,
          ),
        ],
      ),
    );
  }

  // 3. 메뉴 리스트
  Widget _buildMenuList(BuildContext context, MyPageViewModel viewModel) {
    // 메뉴 항목 정의
    final List<String> menus = [
      '내 정보',
      '내 주차장',
      '문의하기',
      '서비스 이용약관',
      '개인정보처리방침',
      '로그아웃',
    ];

    return Column(
      children: menus.map((title) {
        // 구분선 추가 (로그아웃 제외)
        final isLastItem = title == '로그아웃';

        return Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: isLastItem ? Colors.black : Colors.black, // 로그아웃을 특별히 강조하지 않음
                  fontWeight: isLastItem ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
              trailing: isLastItem
                  ? null // 로그아웃에는 화살표 없음
                  : const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                if (title == '로그아웃') {
                  viewModel.logout();
                } else if (title == '내 정보') {
                  // '내 정보' 항목 클릭 시 닉네임 설정 화면으로 이동
                  context.push(RoutePath.myPage_info);
                }
                else {
                  viewModel.navigateTo(title);
                }
              },
            ),
            // 로그아웃 앞에만 구분선을 제거
            if (title != '문의하기' && title != '로그아웃') const Divider(height: 1),
          ],
        );
      }).toList(),
    );
  }

  // 4. 푸터 (앱 버전 및 탈퇴)
  Widget _buildFooter(MyPageViewModel viewModel) {
    const String appVersion = "1.0.0";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "앱 버전",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              Text(
                appVersion,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: viewModel.deleteAccount,
              child: const Text(
                "탈퇴하기 ➱",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}