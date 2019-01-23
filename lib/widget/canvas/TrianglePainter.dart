import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class TrianglePainter extends CustomPainter {
  Paint mPaint;
  final BuildContext mContext;
  TrianglePainter(this.mContext) {
    mPaint = new Paint();
    mPaint.style = PaintingStyle.fill;
    mPaint.color = SMColors.lightGolden;
    mPaint.isAntiAlias = true;

  }

  @override
  void paint(Canvas canvas, Size size) {
    Path path = new Path();
    path.moveTo(20, 15);// 此点为多边形的起点
    path.lineTo(26, 8);
    path.lineTo(28, 8);
    path.lineTo(34, 15);
    path.close();
    canvas.drawPath(path, mPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }


}