import 'config_state.dart';
import 'index.dart';

class MainStore {
  UserState userState;
  TaskhallState taskHallState;
  SmPhotoState smPhotoState;
  HomeTabState homeTabState;
  ConfigState configState;

  MainStore(
      {this.userState,
      this.taskHallState,
      this.smPhotoState,
      this.homeTabState,
      this.configState});
}

MainStore appReducer(MainStore store, dynamic action) {
  return MainStore(
    userState: UserReducer(store.userState, action),
    taskHallState: TaskhallReducer(store.taskHallState, action),
    smPhotoState: SmPhotoReducer(store.smPhotoState, action),
    homeTabState: HomeTabReducer(store.homeTabState, action),
    configState: ConfigReducer(store.configState, action),
  );
}
