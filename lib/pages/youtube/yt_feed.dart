import 'package:flutter/material.dart';
import '../youtube/yt_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

final videoUrls = [
  'https://www.youtube.com/watch?v=nZdjDG1wBus',
  'https://www.youtube.com/watch?v=09PKK8tGQoc',
  'https://www.youtube.com/watch?v=MAKqzsr25kM',
  'https://www.youtube.com/watch?v=rivtc2KCbkE',
  'https://www.youtube.com/watch?v=Mc5Nj65GFmM',
  'https://www.youtube.com/watch?v=QFrMbpwgjMw',
];

class YtFeed extends StatelessWidget {
  const YtFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sunday Session',
          style: GoogleFonts.bebasNeue(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: const Color(0xffE69DB8),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          final videoID = YoutubePlayer.convertUrlToId(videoUrls[index]);

          if (videoID == null) {
            return const SizedBox.shrink(); // Handle invalid video ID gracefully
          }

          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => YtPlayer(videoId: videoID),
                ),
              );
            },
            child: Image.network(
              YoutubePlayer.getThumbnail(videoId: videoID),
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.error,
                ); // Handle thumbnail loading error
              },
            ),
          );
        },
      ),
    );
  }

  // If you want to use this method, fix it like this:
  Widget thumbNail() {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(10),
      color: Colors.pink,
      child: const Text('THUMBNAIL'),
    );
  }
}
