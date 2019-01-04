import 'package:redux/redux.dart';
import 'package:flutter_smallworld/common/model/index.dart';

class UserStore {
  UserInfo userInfo;

  UserStore(this.userInfo);

  static initStore() {
    return UserStore(null);
  }
}


final UserReducer = combineReducers<UserStore>([
  TypedReducer<UserStore, updateUserAction>(_updateUserLoad),
]);

UserStore _updateUserLoad(UserStore userStore, action) {
  userStore.userInfo = action.userInfo;
  return userStore;
}


class updateUserAction {
  final UserInfo userInfo;
  updateUserAction(this.userInfo);
}
