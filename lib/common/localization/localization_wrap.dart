import 'package:flutter/cupertino.dart';

class LocalizationsWidget extends StatefulWidget {
  final Widget child;

  LocalizationsWidget({Key key, this.child}) : super(key: key);

  @override
  State<LocalizationsWidget> createState() {
    return new _LocalizationsState();
  }
}

class _LocalizationsState extends State<LocalizationsWidget> {

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }


}
