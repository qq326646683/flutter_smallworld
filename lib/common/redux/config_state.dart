import 'package:flutter_smallworld/common/model/test/cofig_result_entity.dart';
import 'package:redux/redux.dart';

class ConfigState {
  Entity configEntity;

  ConfigState(this.configEntity);

  static initStore() {
    return ConfigState(null);
  }
}

final ConfigReducer = combineReducers<ConfigState>([
  TypedReducer<ConfigState, UpdateConfigAction>(_updateConfig),
]);

ConfigState _updateConfig(ConfigState userState, action) {
  userState.configEntity = action.configEntity;
  return userState;
}

class UpdateConfigAction {
  final Entity configEntity;

  UpdateConfigAction(this.configEntity);
}
