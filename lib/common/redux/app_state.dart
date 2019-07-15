import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:package_info/package_info.dart';
import 'package:redux/redux.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class AppState {
  PackageInfo packageInfo;
  String registrationID;


  AppState({this.packageInfo, this.registrationID});

  static initStore() {
    return AppState(packageInfo: null, registrationID: "");
  }
}


final AppReducer = combineReducers<AppState>([
  TypedReducer<AppState, UpdatePackageInfoAction>(_updatePackageInfoState),
  TypedReducer<AppState, UpdateRegistrationIDAction>(_updateRegistrationIDState),
]);

AppState _updatePackageInfoState(AppState appState, UpdatePackageInfoAction action) {
  appState.packageInfo = action.packageInfo;
  return appState;
}

AppState _updateRegistrationIDState(AppState appState, UpdateRegistrationIDAction action) {
  appState.registrationID = action.registrationID;
  return appState;
}


class UpdatePackageInfoAction {
  final PackageInfo packageInfo;
  UpdatePackageInfoAction(this.packageInfo);
}
class UpdateRegistrationIDAction {
  final String registrationID;
  UpdateRegistrationIDAction(this.registrationID);
}