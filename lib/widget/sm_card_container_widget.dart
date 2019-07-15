import 'package:flutter/material.dart';

class SMCardContainerWidget extends Container {
  SMCardContainerWidget({
    Key key,
    AlignmentGeometry alignment,
    EdgeInsetsGeometry padding,
    Color color,
    Decoration decoration,
    Decoration foregroundDecoration,
    double width,
    double height,
    BoxConstraints constraints,
    EdgeInsetsGeometry margin,
    Matrix4 transform,
    Widget child,
  })  : assert(margin == null || margin.isNonNegative),
        assert(padding == null || padding.isNonNegative),
        assert(decoration == null || decoration.debugAssertIsValid()),
        assert(constraints == null || constraints.debugAssertIsValid()),
        assert(
            color == null || decoration == null,
            'Cannot provide both a color and a decoration\n'
            'The color argument is just a shorthand for "decoration: new BoxDecoration(color: color)".'),
        super(
          key: key,
          alignment: alignment,
          padding: padding,
          decoration: decoration ??
              BoxDecoration(
                color: color ?? Color.fromARGB(255, 255, 255, 255),
                border: Border.all(
                  color: Color.fromARGB(255, 235, 235, 235),
                  width: 0.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(16, 0, 0, 0),
                    offset: Offset(0, 1),
                    blurRadius: 3,
                  ),
                ],
              ),
          constraints: (width != null || height != null)
              ? constraints?.tighten(width: width, height: height) ??
                  BoxConstraints.tightFor(width: width, height: height)
              : constraints,
          foregroundDecoration: foregroundDecoration,
          width: width,
          height: height,
          margin: margin,
          child: child,
        );
}
