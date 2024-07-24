import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ithkuilingo/explanation_widget.dart';

/// a page displaying several explanations of concepts based on files in the [dirTutorials]
/// it contains a list of buttons with the titles on them
/// if a button is clicked a [ExplanationWidget] with the title and content is shown
class ReferencePageWidget extends StatefulWidget {
  /// creates the reference page based on a hashmap containing title:content associations retrieved from [readDir]

  const ReferencePageWidget({required this.tutorials, super.key});

  /// the hashmap containing the title:content associations
  final LinkedHashMap<String, String> tutorials;

  @override
  State<ReferencePageWidget> createState() => _ReferencePageWidgetState();
}

class _ReferencePageWidgetState extends State<ReferencePageWidget> {
  @override
  Widget build(BuildContext context) {
    // as the number of items is not known we generate them dynamically
    return ListView.builder(
      itemExtent: 50, // this is the height of each button
      itemCount: widget.tutorials.length, // there are as many buttons as titles
      // for each button to generate
      itemBuilder: (context, index) {
        MapEntry<String, String> element = widget.tutorials.entries
            .elementAt(index); // we get the title:content pair for this button
        // and create a button
        return TextButton(
          child: Align(
            alignment: Alignment.centerLeft,
            // containing a hero for animations
            child: Hero(
              tag: element
                  .key, // with the title as a key (that means we assume all titles are unique)
              // this wrapper ensures all styles are applied for the animation
              child: Material(
                color: Colors.transparent,
                child: Text(element
                    .key), // the actual visible Widget is a Label with the title
              ),
            ),
          ),
          // if the Button is pressed
          onPressed: () {
            // we push a new Page
            Navigator.push(
              context,
              MaterialPageRoute(
                // that contains an ExplanationWidget with the title and content of the Button
                builder: (_) => ExplanationWidget(
                  title: element.key,
                  tutorialText: element.value,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

/// Reads a directory and returns title (the first line) and content in a map (Files are alphgabetically ordered)
LinkedHashMap<String, String> readDir(Directory dir) {
  LinkedHashMap<String, String> map =
      LinkedHashMap(); // initializes an empty hashmap !with insertion order!
  var files = dir.listSync(
      recursive:
          false); // returns a list of all files in a folder (synchronously -> waits)
  files.sort((a, b) => a.path.compareTo(
      b.path)); // sorts the files by name -> 00.md listed before 01.md usw...
  for (var file in files) {
    // for every file
    if (file is File) {
      // ensures no directories are accidentally added
      String content =
          file.readAsStringSync(); // read the file content synchronously again
      String title =
          content.split("\n").first; // retrieve the first line as a title
      map[title] = content.replaceFirst(
          title, ""); // save the file in the hashmap as title: rest_of_content
    }
  }
  return map;
}
