import 'package:redux/redux.dart';
import 'package:flutter_smallworld/common/model/taskhall/taskhall.dart';
import 'package:flutter_smallworld/common/model/taskhall/taskhall_progress.dart';
import 'package:flutter_smallworld/common/model/taskhall/taskhall_result.dart';
class TaskhallState {
  TaskhallProgress progress;

  List<Taskhall> taskhallList;


  TaskhallState(this.progress, this.taskhallList);

  static initStore() {
    return TaskhallState(null, []);
  }
}

final TaskhallReducer = combineReducers<TaskhallState>([
  TypedReducer<TaskhallState, setTaskhallInfoAction>(_setTaskhallInfo),
  TypedReducer<TaskhallState, RefreshTaskhallAction>(_refresh),
  TypedReducer<TaskhallState, LoadMoreTaskhallAction>(_loadMore),
]);

TaskhallState _setTaskhallInfo(TaskhallState taskhallState, action){
  taskhallState.progress = action.taskhallResult.progress;
  taskhallState.taskhallList = action.taskhallResult.taskhallList;
  return taskhallState;
}

class setTaskhallInfoAction {
  final TaskhallResult taskhallResult;
  setTaskhallInfoAction(this.taskhallResult);
}

TaskhallState _refresh(TaskhallState taskhallState, action) {
  taskhallState.taskhallList.clear();
  if (action.list == null) {
    return taskhallState;
  } else {
    taskhallState.taskhallList.addAll(action.list);
    return taskhallState;
  }
}

TaskhallState _loadMore(TaskhallState taskhallState, action) {
  if (action.list == null) {
    return taskhallState;
  } else {
    taskhallState.taskhallList.addAll(action.list);
    return taskhallState;
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