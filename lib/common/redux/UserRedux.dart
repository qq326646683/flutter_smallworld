import 'package:redux/redux.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'UserStore.dart';


//final UserReducer = combineReducers<UserStore>([
//  TypedReducer<UserStore, updateUserAction>(_updateUserLoad),
//]);
//
//UserStore _updateUserLoad(UserStore userStore, action) {
//  userStore.userInfo = action.userInfo;
//  return userStore;
//}
//
//
//class updateUserAction {
//  final UserInfo userInfo;
//  updateUserAction(this.userInfo);
//}


final UserReducer = combineReducers<int>([
  TypedReducer<int, updateUserAction>(_updateUserLoad),
]);

int _updateUserLoad(int count, action) {
  return count + action.count;
}


class updateUserAction {
  final int count;
  updateUserAction(this.count);
}