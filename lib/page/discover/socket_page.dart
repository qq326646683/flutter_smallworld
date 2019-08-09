import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/toast_util.dart';

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
  ScrollController scrollController = ScrollController();
  bool _didChangeMetrics = false;
  double _preBottomInset = 0;
  double _bottomInset = 0;
  WidgetsBinding _widgetsBinding = WidgetsBinding.instance;
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    _didChangeMetrics = true;
  }

  @override
  void initState() {
    super.initState();
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
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    _textController.dispose();
    _widgetsBinding.removeObserver(this);
  }

  void _handleSubmitted(String text) {
    if(text==null||text==""){
      ToastUtil.showRed("不要发空消息！！！");
      return;
    }
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
    );
    setState(() {
      _messages.add(message);
      scrollController.animateTo(scrollController.position.maxScrollExtent+50,
          duration: Duration(microseconds: 200), curve: Curves.decelerate);
    });
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
              controller: scrollController,
              padding: EdgeInsets.all(8.0),
              itemBuilder: (_, int index) => _messages[index],
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
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({
    this.text,
    this.isMe = true,
  });

  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        textDirection: isMe ? TextDirection.rtl : TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: isMe ? 0 : 5, left: isMe ? 5 : 0),
            child: CircleAvatar(
              child: Text(
                isMe ? _name : _receiverName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: isMe ? Colors.blue : Colors.grey,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              padding: EdgeInsets.all(10),
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}
