import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:ithkuilingo/explanation_widget.dart';
import 'package:ithkuilingo/lib.dart';

class ReferencePageWidget extends StatefulWidget {
  const ReferencePageWidget(this.tutorials, {super.key});

  final LinkedHashMap<String, String> tutorials;

  @override
  State<ReferencePageWidget> createState() => _ReferencePageWidgetState();
}

class _ReferencePageWidgetState extends State<ReferencePageWidget> {
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
                builder: (_) => ExplanationWidget(
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