import 'package:photo_manager/photo_manager.dart';
import 'package:redux/redux.dart';

class SmPhotoStore {
  List<int> indexList;

  List<AssetEntity> selectList;

  SmPhotoStore(this.indexList, this.selectList);

  static initStore() {
    return SmPhotoStore(new List(), new List<AssetEntity>());
  }

}

final SmPhotoReducer = combineReducers<SmPhotoStore>([
  TypedReducer<SmPhotoStore, updateIndexListAction>(_updateIndexList),
  TypedReducer<SmPhotoStore, updateSelectListAction>(_updateSelectList)
]);

SmPhotoStore _updateIndexList(SmPhotoStore smPhotoStore, updateIndexListAction action) {
  smPhotoStore.indexList = action.indexList;
  return smPhotoStore;
}

SmPhotoStore _updateSelectList(SmPhotoStore smPhotoStore, updateSelectListAction action) {
  smPhotoStore.selectList = action.selectList;
  return smPhotoStore;
}

class updateIndexListAction {
  final List<int> indexList;
  updateIndexListAction(this.indexList);
}

class updateSelectListAction {
  final List<AssetEntity> selectList;
  updateSelectListAction(this.selectList);
}