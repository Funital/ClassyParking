class VideoModel {
  final String title;
  final String duration;
  final String content;
  String status;
  String url;

  VideoModel({
    required this.title,
    required this.duration,
    required this.content,
    required this.status,
    required this.url
  });
}