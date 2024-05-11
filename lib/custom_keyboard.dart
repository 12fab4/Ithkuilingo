import 'dart:math';

import 'package:ithkuilingo/lib.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';
import 'package:flutter/material.dart';

class CKeyboard extends StatefulWidget {
  TextEditingController? controller;
  CKeyboard({super.key, this.controller});

  @override
  State<CKeyboard> createState() => _CKeyboardState();

  void setController(TextEditingController newController) {
    controller = newController;
  }
}

class _CKeyboardState extends State<CKeyboard> {
  TextEditingController? _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: VirtualKeyboard(
        type: VirtualKeyboardType.Alphanumeric,
        textColor: colorText,
        customLayoutKeys: CKeyboardLayout(),
        fontSize: 20,
        onKeyPress: _onKeyPress,
      ),
    );
  }

  _onKeyPress(VirtualKeyboardKey key) {
    if (key.keyType == VirtualKeyboardKeyType.String) {
      setState(() {
        widget.controller?.text += key.text!;
      });
    }
    if (key.action == VirtualKeyboardKeyAction.Backspace) {
      if (widget.controller != null) {
        setState(() {
          widget.controller!.text = widget.controller!.text
              .substring(0, max(widget.controller!.text.length - 1, 0));
        });
      }
    }
    if (key.action == VirtualKeyboardKeyAction.Return) {}
  }
}

class CKeyboardLayout extends VirtualKeyboardDefaultLayoutKeys {
  CKeyboardLayout() : super([VirtualKeyboardDefaultLayouts.English]);

  @override
  int getLanguagesCount() => 1;

  @override
  List<List> getLanguage(int index) {
    // Here is the Keyboard Matrix
    return [
      [
        "a",
        "ä",
        "b",
        "c",
        "č",
        "ç",
        "d",
        "d͕"
      ],
      [
        "e",
        "ë",
        "f",
        "g",
        "h",
        "i",
        "j",
        "k"
      ],
      [
        "l",
        "l͕",
        "m",
        "n",
        "ň",
        "o",
        "ö",
        "p"
      ],
      [
        "r",
        "ř",
        "s",
        "š",
        "t",
        "ţ",
        "u",
        "ü"
      ],
      [
        "v",
        "w",
        "x",
        "y",
        "z",
        "ž",
        "ẓ",
        "'"
      ],
      [
        VirtualKeyboardKeyAction.Return,
        " ",
        VirtualKeyboardKeyAction.Backspace,
      ]
    ];
  }
}
