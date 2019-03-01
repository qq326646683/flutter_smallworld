import 'package:redux/redux.dart';

class SmPhotoStore {
  List<int> indexList;

  SmPhotoStore(this.indexList);

  static initStore() {
    return SmPhotoStore(new List());
  }

}

final SmPhotoReducer = combineReducers<SmPhotoStore>([
  TypedReducer<SmPhotoStore, updateIndexListAction>(_updateIndexList),
]);

SmPhotoStore _updateIndexList(SmPhotoStore smPhotoStore, updateIndexListAction action) {
  smPhotoStore.indexList = action.indexList;
  return smPhotoStore;
}

class updateIndexListAction {
  final List<int> indexList;
  updateIndexListAction(this.indexList);
}