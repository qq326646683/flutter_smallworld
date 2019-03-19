import 'index.dart';

class MainStore {
  UserStore userStore;
  TaskhallStore taskHallStore;
  SmPhotoStore smPhotoStore;
  HomeTabStore homeTabStore;


  MainStore({this.userStore, this.taskHallStore, this.smPhotoStore, this.homeTabStore});

}

MainStore appReducer(MainStore store, dynamic action) {
  return MainStore(
    userStore: UserReducer(store.userStore, action),
    taskHallStore: TaskhallReducer(store.taskHallStore, action),
    smPhotoStore: SmPhotoReducer(store.smPhotoStore, action),
    homeTabStore: HomeTabReducer(store.homeTabStore, action),
  );
}
