import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:flutter_smallworld/common/dao/user_dao.dart';
import 'package:flutter_smallworld/common/redux/main_store.dart';
import 'package:flutter_smallworld/common/redux/user_redux.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/page/index.dart';

class LoginPage extends StatefulWidget {
  static final String sName = "login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _mobile = "";
  String _password = "";

  VideoPlayerController _controller;
  final TextEditingController _mobileController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(SMIcons.LOGIN_BG_MP4);
    _controller.setLooping(true);
    _controller.setVolume(0.0);
    _controller.play();
    _controller.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    print("render: LoginPage");
    return StoreBuilder<MainStore>(builder: (context, store) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Container(
            child: Stack(
              children: <Widget>[
                // 视频
                _controller.value.initialized
                    ? VideoPlayer(_controller)
                    : Container(),
                // 蒙层
                Container(color: SMColors.opacity60Cover),
                // 登陆
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil.getInstance().getWidth(160.0),
                        left: ScreenUtil.getInstance().getWidth(35.0),
                        right: ScreenUtil.getInstance().getWidth(35.0)),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("+86", style: SMTxtStyle.normalTextWhite),
                            Padding(padding: EdgeInsets.all(4.0)),
                            Flexible(
                                child: SMInputWidget(
                                  contentPadding: SMCommonStyle.padding10,
                                  keyboardType: TextInputType.number,
                                  style: SMTxtStyle.normalTextWhite,
                                  hintTextStyle: SMTxtStyle
                                      .normalTextHolderWhite,
                                  controller: _mobileController,
                                  onChanged: (String value) {
                                    _mobile = value;
                                  },
                                  hintText: "输入手机号",
                                )),
                          ],
                        ),
                        SMInputWidget(
                          style: SMTxtStyle.normalTextWhite,
                          hintTextStyle: SMTxtStyle.normalTextHolderWhite,
                          controller: _passwordController,
                          onChanged: (String value) {
                            _password = value;
                          },
                          hintText: "输入密码",
                        ),
                        Padding(
                          padding: EdgeInsets.all(ScreenUtil.getInstance().getWidth(20.0)),
                        ),
                        SMButtonWidget(
                            text: CommonUtils.getLocaleStr(context).login_btn,
                            height: ScreenUtil.getInstance().getWidth(50.0),
                            onPress: () {
                              print("mobile" + _mobile + "psd" + _password);
                              UserDao.login(_mobile, _password, "android", store)
                                .then((res) {
                                  if (res != null && res.result) {
                                    NavigatorUtils.getInstance().pushReplacementNamed(context, MainPage.sName);
                                  }
                              });
                            }
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
