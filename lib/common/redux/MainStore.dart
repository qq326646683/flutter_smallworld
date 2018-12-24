import 'UserStore.dart';
import 'UserRedux.dart';

class MainStore {
  UserStore userStore;

  MainStore({this.userStore});

}

MainStore appReducer(MainStore store, dynamic action) {
  return MainStore(
    userStore: UserReducer(store.userStore, action),

  );
}






