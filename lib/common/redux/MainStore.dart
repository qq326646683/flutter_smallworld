import 'UserStore.dart';
import 'UserRedux.dart';

class MainStore {
//  UserStore userStore;

//  MainStore({this.userStore});

  int count;

  MainStore({this.count});
}

MainStore appReducer(MainStore store, dynamic action) {
  return MainStore(
//    userStore: UserReducer(store.userStore, action),
  count: UserReducer(store.count, action)
  );
}






