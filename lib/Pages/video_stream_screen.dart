import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flood_mobile/Provider/api_provider.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flood_mobile/Route/Arguments/video_stream_screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoStreamScreen extends StatefulWidget {
  VideoStreamScreenArguments args;

  VideoStreamScreen({@required this.args});

  @override
  _VideoStreamScreenState createState() => _VideoStreamScreenState();
}

class _VideoStreamScreenState extends State<VideoStreamScreen> {
  VideoPlayerController _controller;
  String url;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

  _initVideoPlayer() async {
    url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
        ApiProvider.playTorrentVideo +
        '${widget.args.hash}/contents/${widget.args.index}/data';
    _controller = VideoPlayerController.network(url, httpHeaders: {
      'Cookie': Provider.of<UserDetailProvider>(context, listen: false).token
    })
      ..initialize().then((_) {
        setState(() {});
      });
    while (this.mounted) {
      //This keeps updating the progress indicator
      setState(() {});
      await Future.delayed(Duration(seconds: 1), () {});
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _initVideoPlayer();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppColor.primaryColor,
            child: Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Container(
                  child: IconButton(
                    icon: Icon(_controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow),
                    color: Colors.white,
                    iconSize: 50,
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                  ),
                ),
                Slider(
                  inactiveColor: Colors.grey,
                  activeColor: Colors.white,
                  value: _controller.value.position.inSeconds.toDouble(),
                  min: 0.0,
                  max: _controller.value.duration == null
                      ? 1.0
                      : _controller.value.duration.inSeconds.toDouble(),
                  onChanged: (progress) {
                    if (this.mounted) {
                      setState(() {
                        _controller.seekTo(Duration(seconds: progress.toInt()));
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _controller.dispose();
  }
}
