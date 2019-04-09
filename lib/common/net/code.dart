import 'package:event_bus/event_bus.dart';
class Code {
  ///网络错误
  static const NETWORK_ERROR = -1;

  ///网络超时
  static const NETWORK_TIMEOUT = -2;

  ///网络返回数据格式化一次
  static const NETWORK_JSON_EXCEPTION = -3;

  static const SUCCESS = 200;

  static final EventBus eventBus = new EventBus();

  static errorHandleEunction(code, message, noTip) {
    if (noTip) {
      return message;
    }

    eventBus.fire(HttpErrorEvent(code, message));

    return message;
  }

}

class HttpErrorEvent {
  final int code;

  final String message;

  HttpErrorEvent(this.code, this.message);
}