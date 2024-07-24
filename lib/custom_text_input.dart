import 'package:flutter/material.dart';

/// a custom [TextField] implementation required for our keyboard to work properly
class CTextField extends StatefulWidget {
  /// creates a new [CTextField]

  /// this function is called whenever the internal [TextField] has focus
  /// and it should return a [TextEditingController] used to modify the TextField
  final TextEditingController Function()? onFocused;

  /// A custom Inputfield. OnFocussed is callend when starting to enter text (with the textController as the only arg) and onUnFocussed if the Widget loses Focus
  const CTextField({super.key, this.onFocused});

  @override
  State<CTextField> createState() => _CTextFieldState();
}

class _CTextFieldState extends State<CTextField> {
  TextEditingController? controller;

  onTextInput() {}

  @override
  Widget build(BuildContext context) {
    // this wrapper ensures that we detect if the TextField gets the Focus
    return FocusScope(
      // this is an object that can have focus
      child: Focus(
        // and this happens everytime the focus changes
        onFocusChange: (focused) {
          if (focused) {
            // if the TextField has focus
            setState(() {
              controller = widget.onFocused
                  ?.call(); // allows the textField to be edited via eg. the CKeyboard and runs additional code if provided
            });
          }
        },
        // the underlying TextField
        child: TextField(
          controller: controller,
          readOnly:
              true, // so no external keyboards can be used and on mobile OSes no OSK is shown
        ),
      ),
    );
  }
}
