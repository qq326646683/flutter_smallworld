import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class SMInputWidget extends StatefulWidget {
  final TextStyle textStyle;

  final String hintText;

  final TextStyle hintTextStyle;

  final TextInputType keyboardType;

  final ValueChanged<String> onChanged;

  final TextEditingController controller;

  SMInputWidget(
      {Key key,
      this.textStyle,
      this.hintText,
      this.hintTextStyle = SMTxtStyle.middleSubLightText,
      this.keyboardType,
      this.onChanged,
      this.controller})
      : super(key: key);

  @override
  _SMInputWidgetState createState() => _SMInputWidgetState();
}

class _SMInputWidgetState extends State<SMInputWidget> {
  _SMInputWidgetState() : super();

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: widget.textStyle,
      controller: widget.controller,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: widget.hintTextStyle,
          border: InputBorder.none
      ),
    );
  }
}
