import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';

class DragSwipeDemo extends StatefulWidget {
  static final String sName = "dragswipe_demo";

  @override
  _DragSwipeDemoState createState() => _DragSwipeDemoState();
}

class _DragSwipeDemoState extends State<DragSwipeDemo>
    with AutomaticKeepAliveClientMixin<DragSwipeDemo> {
  List<int> data = new List();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      data.add(i);
    }
  }

  void _onReorder(int oldIndex, int newIndex) {
    print('oldIndex:' + oldIndex.toString());
    print('newIndex:' + newIndex.toString());

    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final int item = data.removeAt(oldIndex);
    data.insert(newIndex, item);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
      body: Scrollbar(
        child: ReorderableListView(
          children: data.map<Widget>((i) {
            return DragItem(
              key: Key('__RI__' + i.toString()),
              isTitle: i % 3 == 0,
              index: i,
            );
          }).toList(),
          onReorder: _onReorder,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class DragItem extends StatefulWidget {
  final bool isTitle;
  final int index;

  const DragItem({Key key, this.isTitle, this.index}) : super(key: key);

  @override
  _DragItemState createState() => _DragItemState();
}

class _DragItemState extends State<DragItem> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: ScreenUtil.getInstance().screenWidth,
      decoration: BoxDecoration(
        border: SMCommonStyle.borderBottom03Gray,
        color: widget.isTitle ? Colors.pink : Colors.white,
      ),
      child: Text(
        widget.index.toString(),
        style: SMTextStyle(fontSize: 20),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
