import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class SMZoomWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<double> onScaleChange;

  const SMZoomWidget({Key key, this.child, this.onScaleChange}) : super(key: key);

  @override
  _SMZoomWidgetState createState() => new _SMZoomWidgetState();
}

const double _kMinFlingVelocity = 800.0;

class _SMZoomWidgetState extends State<SMZoomWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _flingAnimation;
  Animation<double> _scaleAnimation;
  Offset _offset = Offset.zero;
  double _scale = 1.0;
  Offset _normalizedOffset;
  double _previousScale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)
      ..addListener(_handleFlingAnimation)
      ..addListener(_handleScaleAnimation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Offset _clampOffset(Offset offset) {

    final Size size = context.size;
    final Offset minOffset = Offset(size.width, size.height) * (1.0 - _scale);
    return Offset(offset.dx.clamp(minOffset.dx, 0.0), offset.dy.clamp(minOffset.dy, 0.0));
  }

  void _handleFlingAnimation() {

    setState(() {
      _offset = _flingAnimation.value;
    });
  }
  void _handleScaleAnimation() {

    setState(() {
      _scale = _scaleAnimation.value;
    });
  }

  void _handleOnScaleStart(ScaleStartDetails details) {
    setState(() {
      _previousScale = _scale;
      _normalizedOffset = (details.focalPoint - _offset) / _scale;
      // The fling animation stops if an input gesture starts.
      _controller.stop();
    });
  }

  void _handleOnScaleUpdate(ScaleUpdateDetails details) {
    print(details.focalPoint.toString() + ':' +_scale.toString());
    setState(() {
      _scale = (_previousScale * details.scale).clamp(1.0, 4.0);
      // Ensure that image location under the focal point stays in the same place despite scaling.
      _offset = _clampOffset(details.focalPoint - _normalizedOffset * _scale);
    });

    widget.onScaleChange?.call(_scale);

  }

  void _handleDoubleTap() {
    Offset tartgetOffset;
    double tartgetScale;
    if (_scale == 1.0 || (_scale > 2.0 && _scale <= 4.0)) {
      tartgetOffset = Offset(-200, -300);
      tartgetScale = 2.0;
    } else {
      tartgetOffset = Offset(0, 0);
      tartgetScale = 1.0;
    }

    _flingAnimation = _controller.drive(Tween<Offset>(
        begin: _offset,
        end: tartgetOffset
    ));
    _scaleAnimation = _controller.drive(Tween<double>(
      begin: _scale,
      end: tartgetScale
    ));
    _controller
      ..value = 0.0
      ..fling();
    _offset = tartgetOffset;
    _scale = tartgetScale;
    widget.onScaleChange?.call(_scale);

  }




  void _handleOnScaleEnd(ScaleEndDetails details) {
    final double magnitude = details.velocity.pixelsPerSecond.distance;
    if (magnitude < _kMinFlingVelocity)
      return;
    final Offset direction = details.velocity.pixelsPerSecond / magnitude;
    final double distance = (Offset.zero & context.size).shortestSide;
    _flingAnimation = _controller.drive(Tween<Offset>(
        begin: _offset,
        end: _clampOffset(_offset + direction * distance)
    ));
    _scaleAnimation = _controller.drive(Tween<double>(
        begin: _scale,
        end: _scale
    ));
    _controller
      ..value = 0.0
      ..fling(velocity: magnitude / 1000.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: _handleOnScaleStart,
      onScaleUpdate: _handleOnScaleUpdate,
      onScaleEnd: _handleOnScaleEnd,
      onDoubleTap: _handleDoubleTap,
      child: ClipRect(
        child: Transform(
          transform: Matrix4.identity()
            ..translate(_offset.dx, _offset.dy)
            ..scale(_scale),
          child: widget.child,
        ),
      ),
    );
  }
}
