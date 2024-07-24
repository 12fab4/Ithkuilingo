import 'package:ithkuilingo/lib.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';
import 'package:flutter/material.dart';

/// our own implementation of a keyboard as normal keyboards dont offer all symbols required for writing ithkuil
/// also with our own internal keyboard we ensure crossplatform compatibility
class CKeyboard extends StatefulWidget {
  /// creates a custom keyboard made to type ithkuil words

  /// the controller the keyboard uses to interact with [TextField]s
  final TextEditingController controller;
  const CKeyboard({super.key, required this.controller});

  @override
  State<CKeyboard> createState() => _CKeyboardState();
}

class _CKeyboardState extends State<CKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter, // the keyboard is at the bottom of the app
      // this is the actual keyboard
      child: VirtualKeyboard(
        type: VirtualKeyboardType.Alphanumeric,
        textColor: colorText, // this is required as it doesnt use the color provided by the theme :(
        customLayoutKeys: CKeyboardLayout(), // but we provide our own layout
        fontSize: 20, // same as in labels
        textController: widget
            .controller, // this makes it posible to actually modify [TextField]s with the keyboard (as long as they share the same controller, which is guaranteed if newTextField() is used)
        onKeyPress: _onKeyPress,
      ),
    );
  }

  void _onKeyPress(VirtualKeyboardKey key) {
    if (key.keyType == VirtualKeyboardKeyType.String) {
      if (key.text == "OK") {
        widget.controller.text = widget.controller.text.replaceFirst("OK", "");
      }
    }
  }
}

class CKeyboardLayout extends VirtualKeyboardDefaultLayoutKeys {
  CKeyboardLayout() : super([VirtualKeyboardDefaultLayouts.English]);

  @override
  int getLanguagesCount() => 1; // the original package offers multiple Keyboardlanguages but we ignore them

  @override
  List<List> getLanguage(int index) {
    // Here is the Keyboard Matrix
    return [
      ["a", "ä", "b", "c", "č", "ç", "d", "d͕"],
      ["e", "ë", "f", "g", "h", "i", "j", "k"],
      ["l", "l͕", "m", "n", "ň", "o", "ö", "p"],
      ["r", "ř", "s", "š", "t", "ţ", "u", "ü"],
      ["v", "w", "x", "y", "z", "ž", "ẓ", "'"],
      [
        "OK", // this string is a special key intended for submitting input
        VirtualKeyboardKeyAction.Space,
        VirtualKeyboardKeyAction.Backspace,
      ]
    ];
  }
}
