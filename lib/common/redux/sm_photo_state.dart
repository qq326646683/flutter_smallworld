import 'package:photo_manager/photo_manager.dart';
import 'package:redux/redux.dart';

class SmPhotoState {
  List<int> indexList;

  List<AssetEntity> selectList;

  SmPhotoState(this.indexList, this.selectList);

  static initStore() {
    return SmPhotoState(new List(), new List<AssetEntity>());
  }

}

final SmPhotoReducer = combineReducers<SmPhotoState>([
  TypedReducer<SmPhotoState, updateIndexListAction>(_updateIndexList),
  TypedReducer<SmPhotoState, updateSelectListAction>(_updateSelectList)
]);

SmPhotoState _updateIndexList(SmPhotoState smPhotoState, updateIndexListAction action) {
  smPhotoState.indexList = action.indexList;
  return smPhotoState;
}

SmPhotoState _updateSelectList(SmPhotoState smPhotoState, updateSelectListAction action) {
  smPhotoState.selectList = action.selectList;
  return smPhotoState;
}

class updateIndexListAction {
  final List<int> indexList;
  updateIndexListAction(this.indexList);
}

class updateSelectListAction {
  final List<AssetEntity> selectList;
  updateSelectListAction(this.selectList);
}