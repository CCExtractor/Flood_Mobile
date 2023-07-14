import 'package:chewie/chewie.dart';
import 'package:flood_mobile/Blocs/api_bloc/api_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Blocs/user_detail_bloc/user_detail_bloc.dart';
import 'package:flood_mobile/Constants/api_endpoints.dart';
import 'package:flood_mobile/Pages/widgets/base_app_bar.dart';
import 'package:flood_mobile/Route/Arguments/video_stream_screen_arguments.dart';
import 'package:flood_mobile/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class VideoStreamScreen extends StatefulWidget {
  final VideoStreamScreenArguments args;

  VideoStreamScreen({required this.args});

  @override
  _VideoStreamScreenState createState() => _VideoStreamScreenState();
}

class _VideoStreamScreenState extends State<VideoStreamScreen> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  late String url;

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
    url = BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
        ApiEndpoints.playTorrentVideo +
        '${widget.args.hash}/contents/${widget.args.index}/data';

    videoPlayerController = VideoPlayerController.network(url, httpHeaders: {
      'Cookie': BlocProvider.of<UserDetailBloc>(context, listen: false).token
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
    _initVideoPlayer();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        appBar: AppBar(),
        themeIndex: widget.args.themeIndex,
      ),
      body: Container(
        color: ThemeBloc.theme(widget.args.themeIndex).primaryColor,
        child: Center(
          child: chewieController != null &&
                  chewieController!.videoPlayerController.value.isInitialized
              ? Chewie(
                  controller: chewieController!,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: ThemeBloc.theme(widget.args.themeIndex)
                          .primaryColorDark,
                    ),
                    SizedBox(height: 20),
                    Text(
                      context.l10n.loading_text,
                      style: TextStyle(
                        color: ThemeBloc.theme(widget.args.themeIndex)
                            .textTheme
                            .bodyLarge!
                            .color,
                      ),
                    ),
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
    chewieController?.dispose();
  }
}
