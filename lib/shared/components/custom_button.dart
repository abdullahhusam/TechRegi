import 'package:flutter/material.dart';

import '../colors/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.marginTop = 0.0,
      this.marginBottom = 0.0,
      this.marginLeft = 0.0,
      this.marginRight = 0.0,
      this.text = "",
      this.fontWeight = FontWeight.w700,
      this.fontSize = 20.0,
      this.fontColor = whiteColor,
      this.backgroundColor = primaryColor,
      this.disabledBackgroundColor = disabledPrimaryColor,
      this.onPressed,
      this.width,
      this.height,
      this.borderRadius,
      this.borderColor});
  final String text;
  final Color fontColor;
  final Color backgroundColor;
  final Color? borderColor;

  final Color disabledBackgroundColor;
  final double fontSize;
  final VoidCallback? onPressed;
  final FontWeight fontWeight;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final double? width;
  final double? height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: marginTop,
          left: marginLeft,
          right: marginRight,
          bottom: marginBottom),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: borderColor != null ? 0 : null,
            padding: EdgeInsets.zero,
            disabledBackgroundColor: disabledBackgroundColor,
            backgroundColor: backgroundColor,
            minimumSize: Size(width ?? double.infinity, height ?? 49),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? 4.0,
              ),
            ),
            side: BorderSide(
                color:
                    borderColor == null ? Colors.transparent : borderColor!)),
        child: Text(
          text,
          style: TextStyle(
              fontSize: fontSize, color: fontColor, fontWeight: fontWeight),
        ),
      ),
    );
  }
}
