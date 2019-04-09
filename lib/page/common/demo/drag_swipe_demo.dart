import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/page/common/demo/sm_reorderable_listview.dart';
import 'package:flutter_smallworld/widget/index.dart';

class DragSwipeDemo extends StatefulWidget {
  static final String sName = "dragswipe_demo";

  @override
  _DragSwipeDemoState createState() => _DragSwipeDemoState();
}

class _DragSwipeDemoState extends State<DragSwipeDemo> {
  List<ItemData> data = new List();
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<
      ScaffoldState>();


  @override
  void initState() {
    super.initState();
    data.add(new ItemData(DataType.timeline, content: '今日任务  03-19  周二'));
    data.add(new ItemData(DataType.task, content: '整理拉蜂改版需求并确认最终界面1'));
    data.add(new ItemData(DataType.task, content: '整理拉蜂改版需求并确认最终界面2'));
    data.add(new ItemData(DataType.task, content: '整理拉蜂改版需求并确认最终界面3'));
    data.add(new ItemData(DataType.addBtn, content: '添加'));

    data.add(new ItemData(DataType.timeline, content: '今日任务  03-18  周一'));
    data.add(new ItemData(DataType.task, content: '整理拉蜂改版需求并确认最终界面4'));
    data.add(new ItemData(DataType.task, content: '整理拉蜂改版需求并确认最终界面5'));
    data.add(new ItemData(DataType.task, content: '整理拉蜂改版需求并确认最终界面6'));
    data.add(new ItemData(DataType.addBtn, content: '添加'));

    data.add(new ItemData(DataType.timeline, content: '今日任务  03-17  周日'));
    data.add(new ItemData(DataType.task, content: '整理拉蜂改版需求并确认最终界面7'));
    data.add(new ItemData(DataType.task, content: '整理拉蜂改版需求并确认最终界面8'));
    data.add(new ItemData(DataType.task, content: '整理拉蜂改版需求并确认最终界面9'));
    data.add(new ItemData(DataType.addBtn, content: '添加'));

    data.add(new ItemData(DataType.timeline, content: '今日任务  03-16  周六'));
    data.add(new ItemData(DataType.task, content: '整理拉蜂改版需求并确认最终界面10'));
    data.add(new ItemData(DataType.task, content: '整理拉蜂改版需求并确认最终界面11'));
    data.add(new ItemData(DataType.task, content: '整理拉蜂改版需求并确认最终界面12'));
    data.add(new ItemData(DataType.addBtn, content: '添加'));

    data.add(new ItemData(DataType.timeline, content: '今日任务  03-15  周五'));
    data.add(new ItemData(DataType.task, content: '整理拉蜂改版需求并确认最终界面13'));
    data.add(new ItemData(DataType.task, content: '整理拉蜂改版需求并确认最终界面14'));
    data.add(new ItemData(DataType.task, content: '整理拉蜂改版需求并确认最终界面15'));
    data.add(new ItemData(DataType.addBtn, content: '添加'));
  }

  void _onReorder(int oldIndex, int newIndex) {
    print('oldIndex:' + oldIndex.toString());
    print('newIndex:' + newIndex.toString());

    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final ItemData item = data.removeAt(oldIndex);
      data.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Scrollbar(
        child: SMReorderableListView(
          children: data.map<Widget>((ItemData itemData) {
            return DragItem(
              key: UniqueKey(),
              itemData: itemData,
            );
          }).toList(),
          onReorder: _onReorder,
        ),
      ),
    );
  }
}


class DragItem extends StatefulWidget {
  final ItemData itemData;

  const DragItem({Key key, this.itemData}) : super(key: key);

//  bool get canDrag => itemData.dataType == DataType.task;

  @override
  _DragItemState createState() => _DragItemState();
}

class _DragItemState extends State<DragItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: ScreenUtil
          .getInstance()
          .screenWidth,
      decoration: BoxDecoration(
        border: SMCommonStyle.borderBottom03Gray,
        color: widget.itemData.dataType == DataType.timeline
            ? Colors.pink
            : Colors.white,
      ),
      child: Text(
        widget.itemData.content.toString(),
        style: SMTextStyle(fontSize: 20),
      ),
    );
  }
}


enum DataType {
  task,
  timeline,
  addBtn
}

class ItemData {
  final DataType dataType;
  final String content;

  ItemData(this.dataType, {this.content});

}
