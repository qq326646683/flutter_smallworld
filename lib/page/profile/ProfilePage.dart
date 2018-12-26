import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/common/redux/index.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('render:ProfilePage');

    return Container(
      color: Colors.purpleAccent,
      child: Column(
        children: <Widget>[
          new StoreConnector<MainStore, String>(
            converter: (store) =>
                store.state.userStore.userInfo.toJson().toString(),
            builder: (context, count) {
              return new Text(
                count != null
                    ? count
                    : 'deffff',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              );
            },
          ),
        ],
      ),
    );
    ;
  }

  @override
  bool get wantKeepAlive => true;
}
