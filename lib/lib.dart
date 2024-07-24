import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';

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

class CText extends Text {
  const CText(super.data,
      {super.key, super.style = textStyleDefault, super.textAlign});
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
