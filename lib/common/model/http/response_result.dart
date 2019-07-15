import 'package:flutter_smallworld/common/net/code.dart';

class ResponseResult<T> {
  T data;
  int statusCode;
  int code;
  String errorMessage;
  // 访问异常时返回的原始数据
  dynamic sourceData;
  ResponseResult();
  ResponseResult.from(this.statusCode, {this.data, this.code, this.errorMessage});

  void fillData(int statusCode, sourceData, T data, int code, String errorMessage) {
    this.statusCode = statusCode;
    this.sourceData = sourceData;
    this.data = data;
    this.code = code;
    this.errorMessage = errorMessage;
  }

  @override
  String toString() {
    return "ResponseResult: [$statusCode, $code]-->$data";
  }

  // 业务成功
  bool get isSuccess => code == Code.CODE_ALL_SUCCESS;

}

