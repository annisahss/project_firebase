class VideoModel {
  final String title;
  final String videoUrl;
  final String channelName;
  final String? videoId;

  VideoModel({
    required this.title,
    required this.videoUrl,
    required this.channelName,
    this.videoId,
  });
}
