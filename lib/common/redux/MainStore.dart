import 'UserRedux.dart';
import 'TaskhallRedux.dart';

class MainStore {
  UserStore userStore;
  TaskhallStore taskHallStore;

  MainStore({this.userStore, this.taskHallStore});

}

MainStore appReducer(MainStore store, dynamic action) {
  return MainStore(
    userStore: UserReducer(store.userStore, action),
    taskHallStore: TaskhallReducer(store.taskHallStore, action),
  );
}
