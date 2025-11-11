import 'package:flutter/material.dart';
import 'video_model.dart';

class VideoViewModel extends ChangeNotifier {
  final List<VideoModel> videos = [
    VideoModel(
      title: '주차 기본 교육',
      duration: '10:00',
      content: '기본적인 주차 방법과 주의사항을 배워보세요.',
      status: 'unwatched',
    ),
    VideoModel(
      title: '후방 주차 교육',
      duration: '8:30',
      content: '후방 주차 시의 각도 조절과 주의 포인트를 알아봅니다.',
      status: 'unwatched',
    ),
    VideoModel(
      title: '평행 주차 교육',
      duration: '12:20',
      content: '좁은 공간에서도 안전하게 평행 주차하는 법을 배웁니다.',
      status: 'unwatched',
    ),
  ];

  void markAsWatched(int index) {
    videos[index].status = 'watched';
    notifyListeners();
  }

  bool get allWatched => videos.every((v) => v.status == 'watched');
}