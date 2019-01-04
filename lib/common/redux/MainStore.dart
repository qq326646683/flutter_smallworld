import 'UserRedux.dart';
import 'TaskHallRedux.dart';

class MainStore {
  UserStore userStore;
  TaskHallStore taskHallStore;

  MainStore({this.userStore, this.taskHallStore});

}

MainStore appReducer(MainStore store, dynamic action) {
  return MainStore(
    userStore: UserReducer(store.userStore, action),
    taskHallStore:
  );
}







