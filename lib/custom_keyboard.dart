import 'dart:math';

import 'package:ithkuilingo/lib.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';
import 'package:flutter/material.dart';

class CKeyboard extends StatefulWidget {
  String text = "";
  CKeyboard({super.key});

  @override
  State<CKeyboard> createState() => _CKeyboardState();
}

class _CKeyboardState extends State<CKeyboard> {
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
      widget.text += key.text!;
    }
    if (key.action == VirtualKeyboardKeyAction.Backspace) {
      widget.text = widget.text.substring(0, max(widget.text.length - 1, 0));
    }
    if (key.action == VirtualKeyboardKeyAction.Return) {
      print(widget.text);
    }
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
        "b",
        "c",
        "ĉ",
      ],
      [
        VirtualKeyboardKeyAction.Backspace,
        VirtualKeyboardKeyAction.Return,
      ]
    ];
  }
}
