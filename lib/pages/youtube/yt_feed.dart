import 'package:flutter/material.dart';
import '../youtube/yt_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
      appBar: AppBar(title: const Center(child: Text('The Sunday Sessions'))),
      body: ListView.builder(
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          final videoID = YoutubePlayer.convertUrlToId(videoUrls[index]);

          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => YtPlayer(videoId: videoID),
                ),
              );
            },
            child: Image.network(YoutubePlayer.getThumbnail(videoId: videoID!)),
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
