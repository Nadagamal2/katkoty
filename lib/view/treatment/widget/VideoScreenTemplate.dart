import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreenTemplate extends StatefulWidget {
  final String videoUrl;
  final String screenTitle;

  const VideoScreenTemplate({
    Key? key,
    required this.videoUrl,
    required this.screenTitle,
  }) : super(key: key);

  @override
  State<VideoScreenTemplate> createState() => _VideoScreenTemplateState();
}

class _VideoScreenTemplateState extends State<VideoScreenTemplate> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  bool _isPlaying = true;
  double _currentPosition = 0;
  double _totalDuration = 0;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '',
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
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _currentPosition = _controller.value.position.inMilliseconds.toDouble();
        _totalDuration =
            _controller.metadata.duration.inMilliseconds.toDouble();
      });
    }
  }

  void togglePlayPause() {
    if (_isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void seekTo(double milliseconds) {
    _controller.seekTo(Duration(milliseconds: milliseconds.toInt()));
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
        title: Text(widget.screenTitle),
        centerTitle: true,
      ),
      body: Column(
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
          /*  SizedBox(height: 10),
          Slider(
            value: _currentPosition,
            min: 0,
            max: _totalDuration,
            onChanged: (newValue) {
              setState(() {
                _currentPosition = newValue;
              });
              seekTo(newValue);
            },
          ),
          SizedBox(height: 10), */
          /*  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Duration(milliseconds: _currentPosition.toInt())
                    .toString()
                    .split('.')
                    .first,
              ),
              Text(
                Duration(milliseconds: _totalDuration.toInt())
                    .toString()
                    .split('.')
                    .first,
              ),
            ],
          ),
          Spacer(), */
        ],
      ),
      /* floatingActionButton: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 320),
          child: FloatingActionButton(
            onPressed: togglePlayPause,
            child: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ), */
    );
  }
}
