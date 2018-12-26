import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> with AutomaticKeepAliveClientMixin<DiscoverPage>{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent
    );
  }

  @override
  bool get wantKeepAlive => true;
}
