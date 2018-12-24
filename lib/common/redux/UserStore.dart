import 'package:flutter_smallworld/common/model/index.dart';

class UserStore {
  UserInfo userInfo;

  UserStore(this.userInfo);

  static initStore() {
    return UserStore(null);
  }
}