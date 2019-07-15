import 'package:flutter_smallworld/common/event/event.dart';

class Code {
  static const STATUS_CODE_SUCCESS = 200;
  ///网络错误
  static const STATUS_CODE_NETWORK_ERROR = -1;
  ///网络超时
  static const STATUS_CODE_NETWORK_TIMEOUT = -2;
  //请求取消
  static const STATUS_CODE_NETWORK_CANCEL = -5;
  //上传失败
  static const STATUS_CODE_UPLOAD_FAILURE = -6;
  //Dio默认错误
  static const STATUS_CODE_DIO_ERROR = -7;

  static const STATUS_CODE_ERROR_401 = 401;

  ///请求成功&业务成功
  static const CODE_ALL_SUCCESS = 666;
  // http status code 错误
  static const CODE_REQUEST_ERROR = -100;
  static const CODE_ERROR_NO_NETWORK = -101;


  //////////////// 业务错误码 /////////////

  // 访问被拒绝
  static const CODE_PERMISSION_DENIED = 20011;
  // 发验证码：手机号不存在
  static const CODE_MIBILE_NOT_EXIST = 20001;
  // 发验证码：验证码请求次数过多
  static const CODE_VERTIFY_SEND_OVER = 20002;
  // 登陆：验证码与手机号码不匹配
  static const CODE_MIBILE_VERTIFY_NOT = 20003;
  // 登陆：账号被禁用，请联系人事
  static const CODE_ACCOUNT_FORBIDDEN = 20004;



  static errorHandleEunction(code, message, noTip) {
    EventBusHelper.fire(HttpErrorEvent(code, message, noTip));

    return code;
  }

}