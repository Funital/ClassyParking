import 'package:classy_parking/core/router/route_path.dart';
import 'package:classy_parking/presentation/screens/home/video/video_view_model.dart';
import 'package:classy_parking/presentation/widgets/custom_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/font.dart';
import '../../../widgets/custom_bottom_button.dart';
import '../../../widgets/video_box.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoViewModel(), // ✅ Scaffold 바깥에 Provider 배치
      child: Scaffold(
        appBar: CustomSubAppBar(title: '주차 교육 영상'),
        backgroundColor: Colors.white,
        bottomNavigationBar: Consumer<VideoViewModel>(
          builder: (context, viewModel, child) => CustomBottomButton(
            text: "시작하기",
            enabled: viewModel.allWatched,
              onPressed: viewModel.allWatched
                  ? () => context.push(RoutePath.home)
                  : null
          ),
        ),

        // ✅ 영상 리스트
        body: Consumer<VideoViewModel>(
          builder: (context, videoViewModel, _) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        const Icon(Icons.directions_car,
                            size: 50, color: Colors.blue),
                        const SizedBox(height: 8),
                        Text(
                          "주차교육영상",
                          style: AppFont.size22
                              .copyWith(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: videoViewModel.videos.length,
                    itemBuilder: (context, index) {
                      final video = videoViewModel.videos[index];
                      final isWatched = video.status == 'watched';

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.play_circle_fill,
                                      color: isWatched ? Colors.green : Colors.red,
                                      size: 40,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            video.title,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            '재생 시간: ${video.duration}',
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        videoViewModel.markAsWatched(index);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                        isWatched ? Colors.green.shade600 : Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text(isWatched ? '시청 완료' : '시청하기'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  video.content, // ✅ 설명 추가
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}