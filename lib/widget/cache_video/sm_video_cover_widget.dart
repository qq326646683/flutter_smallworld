import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:screen/screen.dart';
import 'package:video_player/video_player.dart';

class SMVideoCoverWidget extends StatefulWidget {
  SMVideoCoverWidget(this.controller, {
    this.width,
    VideoProgressColors colors,
    this.padding = const EdgeInsets.only(top: 5.0),
  }) : colors = colors ?? VideoProgressColors();

  final VideoPlayerController controller;
  final VideoProgressColors colors;
  final EdgeInsets padding;
  final double width;

  @override
  _SMVideoCoverWidgetState createState() => _SMVideoCoverWidgetState();
}

class _SMVideoCoverWidgetState extends State<SMVideoCoverWidget> {
  _SMVideoCoverWidgetState() {
    listener = () {
      if (!mounted) {
        return;
      }
      setState(() {});
    };
  }

  VoidCallback listener;

  VideoPlayerController get controller => widget.controller;

  VideoProgressColors get colors => widget.colors;

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
  }

  @override
  void deactivate() {
    controller.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    Widget progressIndicator;
    if (controller.value.initialized) {
      final int duration = controller.value.duration.inMilliseconds;
      final int position = controller.value.position.inMilliseconds;

      int maxBuffering = 0;
      for (DurationRange range in controller.value.buffered) {
        final int end = range.end.inMilliseconds;
        if (end > maxBuffering) {
          maxBuffering = end;
        }
      }

      progressIndicator = Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          LinearProgressIndicator(
            value: maxBuffering / duration,
            valueColor: AlwaysStoppedAnimation<Color>(colors.bufferedColor),
            backgroundColor: colors.backgroundColor,
          ),
          SMLinearProgressIndicator(
            value: position / duration,
            valueColor: AlwaysStoppedAnimation<Color>(colors.playedColor),
            backgroundColor: Colors.transparent,
          ),
        ],
      );
    } else {
      progressIndicator = LinearProgressIndicator(
        value: null,
        valueColor: AlwaysStoppedAnimation<Color>(colors.playedColor),
        backgroundColor: colors.backgroundColor,
      );
    }
    final Widget paddedProgressIndicator = Padding(
      padding: widget.padding,
      child: progressIndicator,
    );
    return Column(
      children: <Widget>[
        Expanded(
          child: _TopScrubber(
            child: Container(color: Color(0x335566ee),),
            controller: controller,
          ),
        ),
        Container(
          width: widget.width,
          height: _Style.bottomBarH,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [SMColors.opacity30Cover, SMColors.opacity60Cover],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(icon: Icon(
                controller.value.isPlaying ? Icons.pause : Icons
                    .play_arrow, color: SMColors.white,), onPressed: () {
                controller.value.isPlaying
                    ? controller.pause()
                    : controller.play();
              }),
              SizedBox(width: _Style.bottomBarChildPadding5,),
              Expanded(
                child: _BottomScrubber(
                  child: paddedProgressIndicator,
                  controller: controller,
                ),
              ),
              SizedBox(width: _Style.bottomBarChildPadding10,),
              Text('${TimeUtil.formatDuration(
                  controller.value.position)}/${TimeUtil.formatDuration(
                  controller.value.duration)}',
                style: SMTxtStyle.minTextWhite,),
              SizedBox(width: _Style.bottomBarChildPadding5,),
              IconButton(icon: Icon(Icons.fullscreen, color: SMColors.white,),
                  onPressed: () {

                  }),
            ],
          ),
        ),

      ],
    );
  }
}

class _BottomScrubber extends StatefulWidget {
  _BottomScrubber({
    @required this.child,
    @required this.controller,
  });

  final Widget child;
  final VideoPlayerController controller;

  @override
  _BottomScrubberState createState() => _BottomScrubberState();
}

class _BottomScrubberState extends State<_BottomScrubber> {
  bool _controllerWasPlaying = false;

  VideoPlayerController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    void seekToRelativePosition(Offset globalPosition) {
      final RenderBox box = context.findRenderObject();
      final Offset tapPos = box.globalToLocal(globalPosition);
      final double relative = tapPos.dx / box.size.width;
      final Duration position = controller.value.duration * relative;
      controller.seekTo(position);
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: widget.child,
      onHorizontalDragStart: (DragStartDetails details) {
        if (!controller.value.initialized) {
          return;
        }
        _controllerWasPlaying = controller.value.isPlaying;
        if (_controllerWasPlaying) {
          controller.pause();
        }
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        if (!controller.value.initialized) {
          return;
        }
        seekToRelativePosition(details.globalPosition);
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        if (_controllerWasPlaying) {
          controller.play();
        }
      },
      onTapDown: (TapDownDetails details) {
        if (!controller.value.initialized) {
          return;
        }
        seekToRelativePosition(details.globalPosition);
      },
    );
  }
}

class _TopScrubber extends StatefulWidget {
  _TopScrubber({
    @required this.child,
    @required this.controller,
  });

  final Widget child;
  final VideoPlayerController controller;

  @override
  _TopScrubberState createState() => _TopScrubberState();
}

class _TopScrubberState extends State<_TopScrubber> {
  Duration seekToDuration;
  Offset horizontalStartOffset;
  Offset verticalStartOffset;
  double seekVolume;
  double seekBrightness;
  bool showBrightness = false;

  VideoPlayerController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    getBrightness();
  }

  getBrightness() async {
    seekBrightness = await Screen.brightness;

  }

    @override
  Widget build(BuildContext context) {

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          widget.child,
          seekToDuration != null ? RichText(
            text: TextSpan(
              children: [
                TextSpan(text: TimeUtil.formatDuration(seekToDuration), style: SMTxtStyle.normalTextGolden),
                TextSpan(text: '/${TimeUtil.formatDuration(controller.value.duration)}', style: SMTxtStyle.normalTextWhite),
              ]
            ),
          ) : SizedBox(),
          seekVolume != null ?
          Positioned(
            right: 40,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              backgroundColor: SMColors.toastGreen,
              value: seekVolume,
            ),
          ) : SizedBox(),
          showBrightness ?
          Positioned(
            left: 40,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              backgroundColor: SMColors.toastRed,
              value: seekBrightness,
            ),
          ) : SizedBox(),
        ],
      ),
      onHorizontalDragStart: (DragStartDetails details) {
        if (!controller.value.initialized) {
          return;
        }
        horizontalStartOffset = details.globalPosition;
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        if (!controller.value.initialized) {
          return;
        }
        recordJumpPosition(details.globalPosition);
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        if (!controller.value.initialized) {
          return;
        }
        controller.seekTo(seekToDuration);
        seekToDuration = null;
        horizontalStartOffset = null;
      },
      onVerticalDragStart: (DragStartDetails details) {
        if (!controller.value.initialized) {
          return;
        }
        verticalStartOffset = details.globalPosition;
      },
      onVerticalDragUpdate: (DragUpdateDetails details) {
        if (!controller.value.initialized) {
          return;
        }
        recordVertical(details.globalPosition);
      },
      onVerticalDragEnd: (DragEndDetails details) {
        if (!controller.value.initialized) {
          return;
        }
        verticalStartOffset = null;
        seekVolume = null;
        showBrightness = false;
        setState(() {
        });
      },
    );
  }

  void recordJumpPosition(Offset horizontalUpdateOffset) {
    final RenderBox box = context.findRenderObject();
    final double relative = (horizontalUpdateOffset.dx - horizontalStartOffset.dx) / box.size.width;

    int jumpSecond = (relative * 60).toInt();
    seekToDuration = controller.value.position + Duration(seconds: jumpSecond);
    if (seekToDuration < Duration(seconds: 0)) {
      seekToDuration = Duration(seconds: 0);
    } else if (seekToDuration > controller.value.duration) {
      seekToDuration = controller.value.duration;
    }
    setState(() {
    });
  }

  void recordVertical(Offset verticalUpdateOffset) {
    final RenderBox box = context.findRenderObject();
    final Offset tapPos = box.globalToLocal(verticalUpdateOffset);
    final bool left = tapPos.dx < box.size.width / 2;
    final double relative = (verticalStartOffset.dy - verticalUpdateOffset.dy) / box.size.height;
    if (left) {
      showBrightness = true;
      seekBrightness = seekBrightness + relative * 0.01;
      if (seekBrightness < 0.0) {
        seekBrightness = 0.0;
      } else if (seekBrightness > 1.0) {
        seekBrightness = 1.0;
      }
      print('seekBrightness');
      print(seekBrightness);
      Screen.setBrightness(seekBrightness);
    } else {
      seekVolume = controller.value.volume + relative * 0.05;
      if (seekVolume < 0.0) {
        seekVolume = 0.0;
      } else if (seekVolume > 1.0) {
        seekVolume = 1.0;
      }
      controller.setVolume(seekVolume);
    }
    setState(() {
    });
  }

}


class _Style {
  static double bottomBarH = ScreenUtil.getInstance().getWidth(50.0);
  static double bottomBarChildPadding5 = ScreenUtil.getInstance().getWidth(3.0);
  static double bottomBarChildPadding10 = ScreenUtil.getInstance().getWidth(
      10.0);
}