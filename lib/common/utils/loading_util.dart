import 'package:flutter/material.dart';
import 'package:flutter_smallworld/widget/index.dart';

class LoadingUtil {
  static OverlayEntry entry = OverlayEntry(builder: (BuildContext context) {
    return SMLoadingWidget();
  });

  static show(BuildContext context) {
    Overlay.of(context).insert(entry);
  }

  static hide() {
    entry.remove();
  }
}
