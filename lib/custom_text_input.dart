import 'package:flutter/material.dart';

class CTextField extends StatefulWidget {
  final TextEditingController Function()? onFocussed;
  final void Function()? onUnfocussed;

  /// A custom Inputfield. OnFocussed is callend when starting to enter text (with the textController as the only arg) and onUnFocussed if the Widget loses Focus
  const CTextField({super.key, this.onFocussed, this.onUnfocussed});

  @override
  State<CTextField> createState() => _CTextFieldState();
}

class _CTextFieldState extends State<CTextField> {
  TextEditingController? controller;

  onTextInput() {}

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        onFocusChange: (focused) {
          if (focused) {
            setState(() {
              controller = widget.onFocussed?.call();
            });
          } else {
            widget.onUnfocussed?.call();
            setState(() {
              // controller = null;
            });
          }
        },
        child: TextField(
          controller: controller,
          readOnly: true,
          showCursor: true,
        ),
      ),
    );
  }
}