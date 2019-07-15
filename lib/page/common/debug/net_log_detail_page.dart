import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';

class NetLogDetailPage extends StatefulWidget {
  static final String sName = "net_log_detail";
  NetLogEntity netLogEntity;

  NetLogDetailPage({this.netLogEntity});

  @override
  _NetLogDetailPageState createState() => _NetLogDetailPageState();
}

class _NetLogDetailPageState extends State<NetLogDetailPage> {
  @override
  Widget build(BuildContext context) {
    NetLogEntity netLogEntity = widget.netLogEntity;
    return Scaffold(
        appBar: SMTitleBarWidget(
          title: '请求详情',
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(title: Text('url', style: SMTxtStyle.middleTextRed), subtitle: Text(netLogEntity.url, style: SMTxtStyle.smallText,), onLongPress: () {_onLongPress(netLogEntity.url);},),
              ListTile(title: Text('method', style: SMTxtStyle.middleTextRed), subtitle: Text(netLogEntity.method, style: SMTxtStyle.smallText,),),
              ListTile(title: Text('status', style: SMTxtStyle.middleTextRed), subtitle: Text(netLogEntity.status != null ? netLogEntity.status.toString() : '', style: SMTxtStyle.smallText,),),
              ListTile(title: Text('timeLime', style: SMTxtStyle.middleTextRed), subtitle: Text('请求时间：${netLogEntity.requestTime.toLocal()} \n收到响应：${netLogEntity.responseTime?.toLocal()} \n报错：${netLogEntity.errorTime?.toLocal()}', style: SMTxtStyle.smallText,),),
              ListTile(title: Text('requestHeader', style: SMTxtStyle.middleTextRed), subtitle: Text(netLogEntity.requestHeader ?? '', style: SMTxtStyle.smallText,), onLongPress: () {_onLongPress(netLogEntity.requestHeader);},),
              ListTile(title: Text('requestBody', style: SMTxtStyle.middleTextRed), subtitle: Text(netLogEntity.requestBody ?? '', style: SMTxtStyle.smallText,), onLongPress: () {_onLongPress(netLogEntity.requestBody);},),
              ListTile(title: Text('responseBody', style: SMTxtStyle.middleTextRed), subtitle: Text(netLogEntity.responseBody ?? '', style: SMTxtStyle.smallText,), onLongPress: () {_onLongPress(netLogEntity.responseBody);},),
              ListTile(title: Text('error', style: SMTxtStyle.middleTextRed), subtitle: Text(netLogEntity.error ?? '', style: SMTxtStyle.smallText,), onLongPress: () {_onLongPress(netLogEntity.error);},),
            ],
          ),
        ));
  }

  _onLongPress(String copyText) async {
    if (copyText != null && copyText.isNotEmpty) {
      await Clipboard.setData(new ClipboardData(text: copyText));
      ToastUtil.showGreen('复制到剪切板');
    }
  }
}
