import 'package:flutter/material.dart';

enum TabType {
  tab_near,
  tab_recent,
  tab_new,
}

class HomeItem extends StatefulWidget {
  final TabType tab;

  HomeItem({@required this.tab});

  @override
  _HomeItemState createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.tab.toString()),
    );
  }
}
