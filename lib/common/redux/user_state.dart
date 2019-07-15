import 'package:redux/redux.dart';
import 'package:flutter_smallworld/common/model/index.dart';

class UserState {
  UserInfo userInfo;

  UserState(this.userInfo);

  static initStore() {
    return UserState(null);
  }
}


final UserReducer = combineReducers<UserState>([
  TypedReducer<UserState, UpdateUserAction>(_updateUserLoad),
]);

UserState _updateUserLoad(UserState userState, action) {
  userState.userInfo = action.userInfo;
  return userState;
}


class UpdateUserAction {
  final UserInfo userInfo;
  UpdateUserAction(this.userInfo);
}
