
import 'package:classy_parking/presentation/screens/home/video/video_model.dart';
import 'package:flutter/cupertino.dart';

class VideoViewModel extends ChangeNotifier {
  final List<VideoModel> videos = [
    VideoModel(title: 'Video 1', duration: '10:00', status: 'Available'),
    VideoModel(title: 'Video 2', duration: '15:30', status: 'Available'),
    VideoModel(title: 'Video 3', duration: '20:00', status: 'Unavailable'),
  ];
}
