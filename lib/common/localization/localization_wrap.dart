import 'package:flutter/material.dart';

class LocalizationWrap extends StatefulWidget {
  final Widget child;

  LocalizationWrap({Key key, this.child}) : super(key: key);

  @override
  _LocalizationWrapState createState() => _LocalizationWrapState();
}

class _LocalizationWrapState extends State<LocalizationWrap> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
