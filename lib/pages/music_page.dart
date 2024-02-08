import 'package:audio_player/constants/app_colors.dart';
import 'package:audio_player/pages/common_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> with WidgetsBindingObserver {
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _init();
  }

  Future<void> _init() async {
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(
          "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")));
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _player.stop();
    }
  }

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              AppColors.purple2,
              AppColors.dark,
              AppColors.purple2
            ])),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).viewPadding.top + 40.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.white,
                  ),
                ),
                const Icon(
                  Icons.more_horiz,
                  color: AppColors.white,
                )
              ],
            ),
            SizedBox(
              height: 40.h,
            ),
            Container(
              height: 380.h,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage('assets/music2.png')),
                  borderRadius: BorderRadius.all(Radius.circular(16))),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You Right',
                      style: TextStyle(
                          fontFamily: GoogleFonts.openSans().fontFamily,
                          fontWeight: FontWeight.w700,
                          fontSize: 24.sp,
                          color: AppColors.white),
                    ),
                    Text(
                      'Doja Cat, The Weeknd',
                      style: TextStyle(
                          color: AppColors.lightGrey,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp),
                    )
                  ],
                ),
                const Icon(
                  Icons.favorite_outline,
                  color: AppColors.white,
                )
              ],
            ),

            SizedBox(
              height: 40.h,
            ),
            StreamBuilder<PositionData>(
              stream: _positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return SeekBar(
                  duration: positionData?.duration ?? Duration.zero,
                  position: positionData?.position ?? Duration.zero,
                  bufferedPosition:
                      positionData?.bufferedPosition ?? Duration.zero,
                  onChangeEnd: _player.seek,
                );
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            ControlButtons(_player),
            // Display seek bar. Using StreamBuilder, this widget rebuilds
            // each time the position, buffered position or duration changes.
          ],
        ),
      ),
    );
  }
}

/// Displays the play/pause button and volume/speed sliders.
class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.shuffle,
          color: AppColors.white,
          size: 32.sp,
        ),
        const Spacer(),
        Icon(
          Icons.skip_previous_sharp,
          color: AppColors.white,
          size: 36.sp,
        ),
        SizedBox(
          width: 20.w,
        ),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return GestureDetector(
                onTap: player.play,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/btn_background.png'),
                    const Icon(
                      Icons.play_arrow,
                      color: AppColors.white,
                    ),
                  ],
                ),
              );
            } else if (processingState != ProcessingState.completed) {
              return GestureDetector(
                onTap: player.pause,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/btn_background.png'),
                    const Icon(
                      Icons.pause,
                      color: AppColors.white,
                    ),
                  ],
                ),
              );
            } else {
              return GestureDetector(
                onTap: () => player.seek(Duration.zero),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/btn_background.png'),
                    const Icon(
                      Icons.replay,
                      color: AppColors.white,
                    ),
                  ],
                ),
              );
            }
          },
        ),
        // Opens speed slider dialog
        SizedBox(
          width: 20.w,
        ),
        Icon(
          Icons.skip_next_sharp,
          color: AppColors.white,
          size: 36.sp,
        ),
        const Spacer(),
        Icon(
          Icons.repeat,
          color: AppColors.white,
          size: 32.sp,
        ),
        // StreamBuilder<double>(
        //   stream: player.speedStream,
        //   builder: (context, snapshot) => IconButton(
        //     icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
        //         style: const TextStyle(
        //             color: AppColors.white, fontWeight: FontWeight.bold)),
        //     onPressed: () {
        //       showSliderDialog(
        //         context: context,
        //         title: "Adjust speed",
        //         divisions: 10,
        //         min: 0.5,
        //         max: 1.5,
        //         value: player.speed,
        //         stream: player.speedStream,
        //         onChanged: player.setSpeed,
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
