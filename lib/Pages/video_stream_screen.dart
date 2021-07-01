import 'package:chewie/chewie.dart';
import 'package:flood_mobile/Components/base_app_bar.dart';
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
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;
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

    videoPlayerController = VideoPlayerController.network(url, httpHeaders: {
      'Cookie': Provider.of<UserDetailProvider>(context, listen: false).token
    })
      ..initialize().then((_) {
        setState(() {});
      });

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      looping: true,
    );
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
      appBar: BaseAppBar(
        appBar: AppBar(),
      ),
      body: Container(
        color: AppColor.primaryColor,
        child: Center(
          child: chewieController != null &&
                  chewieController.videoPlayerController.value.isInitialized
              ? Chewie(
                  controller: chewieController,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(
                      color: AppColor.greenAccentColor,
                    ),
                    SizedBox(height: 20),
                    Text('Loading'),
                  ],
                ),
        ),
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
    videoPlayerController.dispose();
    chewieController.dispose();
  }
}
