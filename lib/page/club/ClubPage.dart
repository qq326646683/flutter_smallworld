import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class ClubPage extends StatefulWidget {
  @override
  _ClubPageState createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> with AutomaticKeepAliveClientMixin<ClubPage>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('_ClubPageState');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent
    );
  }

  @override
  bool get wantKeepAlive => true;
}
