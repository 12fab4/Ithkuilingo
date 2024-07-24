import 'dart:io';

import 'package:flutter/material.dart';

// Some colors used frequently
/// color used for backgrounds
const Color colorBackground = Color.fromARGB(255, 15, 0, 26);

/// the primary color
const Color colorDefault = Color.fromARGB(255, 149, 0, 255);

/// the secondary color used for header and footer bars
const Color colorDefaultLight = Color.fromARGB(255, 165, 39, 255);

/// the color used for wrong stuff
const Color colorError = Color.fromARGB(255, 100, 0, 0);

/// the color used for right stuff
const Color colorRight = Color.fromARGB(255, 89, 0, 153);

/// the color used for all text
const Color colorText = Color.fromARGB(255, 230, 230, 230);

// some default paths
/// used primarily for images referenced in markdown files
var dirImages = Directory("data/images");

/// used to find markdown files to show on the reference page
var dirTutorials = Directory("data/tutorials");
