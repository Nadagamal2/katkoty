import 'package:flutter/material.dart';
import 'package:katkoty/packages/alarm/models/course_details_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../widgets/bnner_ad.dart';

class YoutubeVideoScreen extends StatefulWidget {
  final CoursesContent content;
  const YoutubeVideoScreen({super.key, required this.content});

  @override
  State<YoutubeVideoScreen> createState() => _YoutubeVideoScreenState();
}

class _YoutubeVideoScreenState extends State<YoutubeVideoScreen> {
  late YoutubePlayerController _controller;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  final double _volume = 100;
  final bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(widget.content.url ?? '') ?? '',
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.content.title ?? '--'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
              progressColors: const ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
              onReady: () {
                _isPlayerReady = true;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  widget.content.description ?? '--',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
