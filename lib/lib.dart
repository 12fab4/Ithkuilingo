import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

// Some colors used frequently
const Color colorBackground = Color.fromARGB(255, 15, 0, 26);
const Color colorDefault = Color.fromARGB(255, 149, 0, 255);
const Color colorDefaultLight = Color.fromARGB(255, 165, 39, 255);
const Color colorError = Color.fromARGB(255, 100, 0, 0);
const Color colorRight = Color.fromARGB(255, 89, 0, 153);
const Color colorText = Color.fromARGB(255, 230, 230, 230);

// Some Textstyles used frequently
TextStyle customTextStyle(
    {Color color = colorText, double fontSize = 20, double height = 1.2}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    height: height,
  );
}

const TextStyle textStyleDefault = TextStyle(
  color: colorText,
  fontSize: 20,
  height: 1.2,
);

const TextStyle textStyleHeading = TextStyle(
  color: colorText,
  fontSize: 30,
  height: 1.2,
);

const TextStyle textStyleSubHeading = TextStyle(
  color: colorText,
  fontSize: 26,
  height: 1.2,
);

// some default paths
const String dirImages = "data/images";
const String dirTutorials = "data/tutorials";

/// Creates a Widget, that displays a markdown file with title in the AppBar
class TutorialWidget extends StatefulWidget {
  final String tutorialText;
  final String title;

  const TutorialWidget(
    this.title,
    this.tutorialText, {
    super.key,
  });

  @override
  State<TutorialWidget> createState() => _TutorialWidgetState();
}

class _TutorialWidgetState extends State<TutorialWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorDefaultLight,
        title: Hero(
          tag: widget.title,
          child: Material(
              color: Colors.transparent,
              child: CText(
                widget.title,
                style: textStyleHeading,
              )),
        ),
      ),
      body: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
        decoration: const BoxDecoration(color: colorBackground),
        child: Markdown(
          styleSheet: MarkdownStyleSheet(
            p: textStyleDefault,
            h1: textStyleHeading,
            h2: textStyleSubHeading,
            listBullet: textStyleDefault,
            // horizontalRuleDecoration: BoxDecoration(color: colorText),
          ),
          imageDirectory: "data/images/",
          selectable: true,
          syntaxHighlighter: null,
          data: widget.tutorialText,
        ),
      ),
    );
  }
}

class CText extends Text {
  const CText(super.data,
      {super.key, super.style = textStyleDefault, super.textAlign});
}

class TutorialsWidget extends StatefulWidget {
  const TutorialsWidget(this.tutorials, {super.key});

  final LinkedHashMap<String, String> tutorials;

  @override
  State<TutorialsWidget> createState() => _TutorialsWidgetState();
}

class _TutorialsWidgetState extends State<TutorialsWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 50,
      itemCount: widget.tutorials.length,
      itemBuilder: (context, index) {
        MapEntry<String, String> element =
            widget.tutorials.entries.elementAt(index);
        return TextButton(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Hero(
              tag: element.key,
              child: Material(
                color: Colors.transparent,
                child: CText(element.key),
              ),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TutorialWidget(
                  element.key,
                  element.value,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

/// Reads a directory and returns Title (the first line) and content in a map (Files are alphgabetically ordered)
LinkedHashMap<String, String> readDir(String path) {
  var dir = Directory(path);
  LinkedHashMap<String, String> map = LinkedHashMap();
  var files = dir.listSync(recursive: false);
  files.sort((a, b) => a.path.compareTo(b.path));
  for (var file in files) {
    if (file is File) {
      String content = file.readAsStringSync();
      String title = content.split("\n").first;
      map[title] = content.replaceFirst(title, "");
    }
  }
  return map;
}

class CTextField extends StatefulWidget {
  final void Function(TextEditingController)? onFocussed;
  final void Function()? onUnfocussed;
  final controller = TextEditingController(text: "ABC");

  /// A custom Inputfield. OnFocussed is callend when starting to enter text (with the textController as the only arg) and onUnFocussed if the Widget loses Focus
  CTextField({super.key, this.onFocussed, this.onUnfocussed});

  @override
  State<CTextField> createState() => _CTextFieldState();
}

class _CTextFieldState extends State<CTextField> {

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        onFocusChange: (focused) {
          if (focused) {
            widget.onFocussed?.call(widget.controller);
          } else {
            widget.onUnfocussed?.call();
          }
        },
        child: TextField(
          controller: widget.controller,
          // readOnly: true,
          showCursor: true,
        ),
      ),
    );
  }
}
