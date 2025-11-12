import 'package:flutter/material.dart';
import 'video_model.dart';

class VideoViewModel extends ChangeNotifier {
  final List<VideoModel> videos = [
    VideoModel(
      title: '주차 기본 교육',
      duration: '10:00',
      content: '기본적인 주차 방법과 주의사항을 배워보세요.',
      status: 'unwatched',
      url: 'https://www.youtube.com/watch?v=BObmj7K9WOg',
    ),
    VideoModel(
      title: '리스펙 파킹 교육',
      duration: '8:30',
      content: '불법 주차에 정의와 위험성을 배워보세요',
      status: 'unwatched',
      url: 'https://www.youtube.com/watch?v=qYEfjliiYCM',
    ),
  ];

  void markAsWatched(int index) {
    videos[index].status = 'watched';
    notifyListeners();
  }

  bool get allWatched => videos.every((v) => v.status == 'watched');
}