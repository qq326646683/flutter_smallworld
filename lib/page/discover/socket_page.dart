import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/toast_util.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

const String _name = "ME";
const String _receiverName = "YOU";

class SocketPage extends StatefulWidget {
  static final String sName = "socketPage";

  @override
  _SocketPageState createState() => _SocketPageState();
}

class _SocketPageState extends State<SocketPage> with WidgetsBindingObserver {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();
  int fakeReceivedMsgPos = 0;
  bool _didChangeMetrics = false;
  double _preBottomInset = 0;
  double _bottomInset = 0;
  WidgetsBinding _widgetsBinding = WidgetsBinding.instance;
  AutoScrollController controller;

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    _didChangeMetrics = true;
  }

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);
    _widgetsBinding.addObserver(this);
    _widgetsBinding.addPersistentFrameCallback((Duration timeStamp) {
      if (!_didChangeMetrics) {
        return;
      }
      _preBottomInset = _bottomInset;
      _bottomInset = MediaQuery.of(context).viewInsets.bottom;
      if (_preBottomInset != _bottomInset) {
        _widgetsBinding.scheduleFrame();
        return;
      }
      _didChangeMetrics = false;
      controller.scrollToIndex(_messages.length - 1);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    _textController.dispose();
    _widgetsBinding.removeObserver(this);
  }

  void _handleSubmitted(String text) {
    if (text == null || text == "") {
      ToastUtil.showRed("不要发空消息！！！");
      return;
    }
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
    );
    setState(() {
      _messages.add(message);
    });
    controller.scrollToIndex(_messages.length-1);
  }

  Widget _buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(hintText: "发送消息"),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: GestureDetector(
          child: Text("ChatPage"),
          onTap: () {
            _fakeReceiveMsg();
          },
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: controller,
              padding: EdgeInsets.all(8.0),
              itemBuilder: (_, int index) {
                ChatMessage msg = _messages[index];
                return AutoScrollTag(
                  key: ValueKey(index),
                  controller: controller,
                  index: index,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      textDirection:
                          msg.isMe ? TextDirection.rtl : TextDirection.ltr,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              right: msg.isMe ? 0 : 5, left: msg.isMe ? 5 : 0),
                          child: CircleAvatar(
                            child: Text(
                              msg.isMe ? _name : _receiverName,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor:
                                msg.isMe ? Colors.blue : Colors.grey,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: msg.isMe ? Colors.blue : Colors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Text(msg.text),
                          ),
                        ),
                      ],
                    ),
                  ),
                  highlightColor: Colors.black.withOpacity(0.1),
                );
              },
              itemCount: _messages.length,
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Colors.grey),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  void _fakeReceiveMsg() {
    fakeReceivedMsgPos++;
    String receivedMsg =
        fakeReceivedMsgPos.toString() + ": 我是测试的收到了消息啦啦啦啦啦啦啦啦啦假消息";
    ChatMessage message = ChatMessage(
      text: receivedMsg,
      isMe: false,
    );
    setState(() {
      _messages.add(message);
    });
    if (isAtBottom()) {
      controller.scrollToIndex(_messages.length - 1);
    }
  }

  bool isAtBottom() {
    bool isAtBottom = false;
    if ( controller.position.maxScrollExtent==controller.position.pixels&&controller.position.maxScrollExtent!=0) {
      isAtBottom = true;
    }
     return isAtBottom;
  }
}

class ChatMessage {
  ChatMessage({
    this.text,
    this.isMe = true,
  });
  final String text;
  final bool isMe;
}
