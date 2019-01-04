class TaskHallStore {
  TaskHallProgress progress;

  List<Taskhall> taskhallList;


  TaskHallStore(this.progress, this.taskhallList);

  static initStore() {
    return TaskHallStore(null, []);
  }
}