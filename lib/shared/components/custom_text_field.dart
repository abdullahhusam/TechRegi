import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../colors/colors.dart';

enum Type { phone, email, name, password, confirmPassword }

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      this.labelText,
      required this.controller,
      this.marginTop = 15.0,
      this.marginBottom = 0.0,
      this.marginLeft = 0.0,
      this.marginRight = 0.0,
      this.marginAll = 0.0,
      required this.onChanged,
      this.type = Type.name,
      this.isValid = IsValid.none,
      this.enabled = true,
      this.hintText});
  final String? labelText;
  final String? hintText;
  final TextEditingController controller;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final double marginAll;
  final ValueChanged<String>? onChanged;
  final IsValid isValid;
  final Type type;
  final bool enabled;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  final Color _validBorderColor = Colors.transparent;
  final Color _notValidBorderColor = doesNotMatchError;
  final Color _focusBorderColor = Colors.transparent;
  var _isFocused = false;

  bool _hideText = true;
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (widget.isValid == IsValid.none) {
        setState(() {
          if (_focusNode.hasFocus) {
            _isFocused = true;
          } else {
            _isFocused = false;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: authContainerHeight,
      padding: const EdgeInsets.fromLTRB(12, 0, 4, 0),
      decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(
              color: widget.isValid == IsValid.none
                  ? _isFocused
                      ? _focusBorderColor
                      : Colors.transparent
                  : widget.isValid == IsValid.valid
                      ? _validBorderColor
                      : _notValidBorderColor),
          borderRadius: BorderRadius.circular(8.0)),
      margin: widget.marginAll > 0
          ? EdgeInsets.all(widget.marginAll)
          : EdgeInsets.only(
              top: widget.marginTop,
              left: widget.marginLeft,
              right: widget.marginRight,
              bottom: widget.marginBottom),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.top,
        enabled: widget.enabled,
        obscuringCharacter: '*',
        cursorColor: textColor,
        cursorHeight: 19,
        keyboardType: widget.type == Type.phone
            ? TextInputType.number
            : TextInputType.text,
        onChanged: (text) {
          if (widget.onChanged != null) {
            widget.onChanged!(text);
          }
        },
        focusNode: _focusNode,
        obscureText:
            widget.type == Type.password || widget.type == Type.confirmPassword
                ? _hideText
                : false,
        controller: widget.controller,
        style: const TextStyle(
            color: textColor, fontSize: 16.0, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
            isDense: widget.hintText != null ? false : true,
            suffixIcon: widget.type == Type.password ||
                    widget.type == Type.confirmPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _hideText = !_hideText;
                      });
                    },
                    icon: Transform.scale(
                      alignment: Alignment.center,
                      scaleX: -1,
                      child: Icon(
                        _hideText
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20,
                      ),
                    ))
                : null,
            labelStyle:
                const TextStyle(color: textColor, fontWeight: FontWeight.w400),
            labelText: widget.labelText,
            hintText: widget.hintText,
            hintStyle: const TextStyle(
                color: hintTextColor,
                fontWeight: FontWeight.w400,
                fontSize: 16),
            border: InputBorder.none),
      ),
    );
  }
}
