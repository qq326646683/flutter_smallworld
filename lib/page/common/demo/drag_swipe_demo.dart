import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';

class DragSwipeDemo extends StatefulWidget {
  static final String sName = "dragswipe_demo";

  @override
  _DragSwipeDemoState createState() => _DragSwipeDemoState();
}

class _DragSwipeDemoState extends State<DragSwipeDemo> {
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<
      ScaffoldState>();
  bool _gestureToParent = true;
  Map<Type, GestureRecognizerFactory> pageviewGesture;
  Map<Type, GestureRecognizerFactory> imageviewGesture;

  Map<Type, GestureRecognizerFactory> commonPageViewGesture;
  Map<Type, GestureRecognizerFactory> commonImageViewGesture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageviewGesture = {
      PageViewGestureRecognizer: GestureRecognizerFactoryWithHandlers<
          PageViewGestureRecognizer>(
            () => PageViewGestureRecognizer(),
            (PageViewGestureRecognizer instance) {
          instance.onTap = () => print('click:pageview');
        },
      )
    };
    commonPageViewGesture = {
      TapGestureRecognizer: GestureRecognizerFactoryWithHandlers<
          TapGestureRecognizer>(
            () => TapGestureRecognizer(),
            (TapGestureRecognizer instance) {
          instance.onTap = () => print('click:pageview');
        },
      )
    };
    imageviewGesture = {
      ImageViewGestureRecongnizer: GestureRecognizerFactoryWithHandlers<
          ImageViewGestureRecongnizer>(
            () => ImageViewGestureRecongnizer(),
            (ImageViewGestureRecongnizer instance) {
          instance.onTap = () => print('click:imageview');
        },
      )
    };
    commonImageViewGesture = {
      TapGestureRecognizer: GestureRecognizerFactoryWithHandlers<
          TapGestureRecognizer>(
            () => TapGestureRecognizer(),
            (TapGestureRecognizer instance) {
          instance.onTap = () => print('click:imageview');
        },
      )
    };
  }


  @override
  Widget build(BuildContext context) {
    print('_gestureToParent:' + _gestureToParent.toString());
    return RawGestureDetector(
      gestures: _gestureToParent ? pageviewGesture : commonPageViewGesture,
      child: Container(
        color: SMColors.actionBlue,
        child: RawGestureDetector(
          behavior: HitTestBehavior.translucent,
          gestures: _gestureToParent ? imageviewGesture : commonImageViewGesture,
          child: Container(
            color: SMColors.darkGolden,
            child: Column(
              children: <Widget>[
                RaisedButton(onPressed: () {
                  this.setState(() {
                    _gestureToParent = !_gestureToParent;
                  });
                }, child: Text('switch'),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class PageViewGestureRecognizer extends TapGestureRecognizer {
//  bool get toParent => _gestureToParent;
//  bool _gestureToParent = true;
//  /// The [gestureToParent] can only be set once.
//  set gestureToParent(bool value) {
//    assert(value != null);
//    assert(_gestureToParent == null);
//    _gestureToParent = value;
//  }
  @override
  void rejectGesture(int pointer) {
//    if (_gestureToParent) {
      super.acceptGesture(pointer);
//    } else {
//      super.rejectGesture(pointer);
//    }
  }

}

class ImageViewGestureRecongnizer extends TapGestureRecognizer {
//  bool get toParent => _gestureToParent;
//  bool _gestureToParent = true;
//  /// The [gestureToParent] can only be set once.
//  set gestureToParent(bool value) {
//    assert(value != null);
//    assert(_gestureToParent == null);
//    _gestureToParent = value;
//  }
  @override
  void acceptGesture(int pointer) {
//    if (_gestureToParent) {
      super.rejectGesture(pointer);
//    } else {
//      super.acceptGesture(pointer);
//    }
  }
}
