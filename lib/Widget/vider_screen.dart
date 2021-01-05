import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatelessWidget {
  final String videoId;
  VideoScreen(this.videoId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: YoutubePlayer(
                controller: YoutubePlayerController(initialVideoId: videoId)),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height *.05,
            left: MediaQuery.of(context).size.width *.04,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
