import 'index.dart';

class MainStore {
  UserStore userStore;
  TaskhallStore taskHallStore;
  SmPhotoStore smPhotoStore;


  MainStore({this.userStore, this.taskHallStore, this.smPhotoStore});

}

MainStore appReducer(MainStore store, dynamic action) {
  return MainStore(
    userStore: UserReducer(store.userStore, action),
    taskHallStore: TaskhallReducer(store.taskHallStore, action),
    smPhotoStore: SmPhotoReducer(store.smPhotoStore, action),
  );
}
