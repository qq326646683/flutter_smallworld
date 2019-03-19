import 'package:redux/redux.dart';
import 'package:flutter_smallworld/common/model/taskhall/Taskhall.dart';
import 'package:flutter_smallworld/common/model/taskhall/TaskhallProgress.dart';
import 'package:flutter_smallworld/common/model/taskhall/TaskhallResult.dart';
class TaskhallStore {
  TaskhallProgress progress;

  List<Taskhall> taskhallList;


  TaskhallStore(this.progress, this.taskhallList);

  static initStore() {
    return TaskhallStore(null, []);
  }
}

final TaskhallReducer = combineReducers<TaskhallStore>([
  TypedReducer<TaskhallStore, setTaskhallInfoAction>(_setTaskhallInfo),
  TypedReducer<TaskhallStore, RefreshTaskhallAction>(_refresh),
  TypedReducer<TaskhallStore, LoadMoreTaskhallAction>(_loadMore),
]);

TaskhallStore _setTaskhallInfo(TaskhallStore taskhallStore, action){
  taskhallStore.progress = action.taskhallResult.progress;
  taskhallStore.taskhallList = action.taskhallResult.taskhallList;
  return taskhallStore;
}

class setTaskhallInfoAction {
  final TaskhallResult taskhallResult;
  setTaskhallInfoAction(this.taskhallResult);
}

TaskhallStore _refresh(TaskhallStore taskhallStore, action) {
  taskhallStore.taskhallList.clear();
  if (action.list == null) {
    return taskhallStore;
  } else {
    taskhallStore.taskhallList.addAll(action.list);
    return taskhallStore;
  }
}

TaskhallStore _loadMore(TaskhallStore taskhallStore, action) {
  if (action.list == null) {
    return taskhallStore;
  } else {
    taskhallStore.taskhallList.addAll(action.list);
    return taskhallStore;
  }
}

class RefreshTaskhallAction {
  final List<Taskhall> list;

  RefreshTaskhallAction(this.list);
}

class LoadMoreTaskhallAction {
  final List<Taskhall> list;

  LoadMoreTaskhallAction(this.list);
}