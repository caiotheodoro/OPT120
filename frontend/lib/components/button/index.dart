import 'package:flutter/material.dart';

class CustomButtonStyle {
  final Color backgroundColor;
  final Color hoverColor;
  final Color borderColor;
  final double borderRadius;
  final double padding;

  CustomButtonStyle({
    required this.backgroundColor,
    required this.hoverColor,
    required this.borderColor,
    required this.borderRadius,
    required this.padding,
  });

  ButtonStyle getStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
      overlayColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered)) {
            return hoverColor;
          }
          return Colors.transparent;
        },
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: borderColor, width: 1),
        ),
      ),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        EdgeInsets.all(padding),
      ),
    );
  }
}