import 'package:classy_parking/presentation/screens/home/video/video_view_model.dart';
import 'package:classy_parking/presentation/widgets/custom_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/font.dart';
import '../../../widgets/video_box.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSubAppBar(title: '주차 교육 영상'),
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider(
        create: (_) => VideoViewModel(),
        child: Consumer<VideoViewModel>(
          builder: (context, videoViewModel, _) {
            return SingleChildScrollView(
              child: Column(
                children: [
                const SizedBox(height: 20,),
              Center(
                child: Column(
                  children: [
                    Icon(Icons.directions_car, size: 50, color: Colors.blue),
                    SizedBox(height: 8),
                    Text(
                      "주차교육영상",
                      style: AppFont.size22.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                  ),
              const SizedBox(height: 20,),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                    itemCount: videoViewModel.videos.length,
                    itemBuilder: (context, index) {
                      final video = videoViewModel.videos[index];
                      return VideoBox(
                        title: video.title,
                        duration: video.duration,
                        status: video.status,
                        onTap: () {  },
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
