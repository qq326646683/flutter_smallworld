import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/config/config.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/service/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/page/index.dart';
import 'package:flutter_smallworld/widget/index.dart';

class NetLogPage extends StatefulWidget {
  static final String sName = "net_log";

  @override
  _NetLogPageState createState() => _NetLogPageState();
}

class _NetLogPageState extends State<NetLogPage> {
  NetLogEntityList netLogEntityList;
  List<NetLogEntity> targetNetLogEntityList;
  @override
  void initState() {
    super.initState();
    getLog();
  }

  Future getLog() async {
    NetLogEntityList spNetLogEntityList = await NetLogService.getInstance().getFromSP();
    netLogEntityList = spNetLogEntityList;
    if (netLogEntityList != null) {
      targetNetLogEntityList = netLogEntityList.netLogEntityList.reversed.toList();
    } else {
      targetNetLogEntityList = [];
    }
    this.setState((){});
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (netLogEntityList != null) {
      body = ListView.builder(
        itemCount: targetNetLogEntityList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              NavigatorUtils.getInstance().pushNamed(context, NetLogDetailPage.sName, (context) => NetLogDetailPage(netLogEntity: targetNetLogEntityList[index],));
            },
            child: SMCardContainerWidget(
              margin: SMCommonStyle.paddingHori10Vert5,
              padding: SMCommonStyle.padding10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${targetNetLogEntityList[index].url} [${targetNetLogEntityList[index].method}]', style: SMTxtStyle.middleText,),
                  SizedBox(height: 5,),
                  Text(targetNetLogEntityList[index].requestTime.toLocal().toString(), style: SMTxtStyle.smallSubText,)
                ],
              ),
            ),
          );
        },
      );
    } else {
      body = Container();
    }

    return Scaffold(
      appBar: SMTitleBarWidget(
        title: '请求日志',
        rightTitle: '清空',
        rightClick: () async {
          await StorageManager.getInstance().remove(Config.NETLOG_KEY);
          getLog();
        },
      ),
      body: Container(
        child: body,
      ),
    );


  }

}
