import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

/// a Widget intendet to be pushed via Navigator.push() that displays a Markdownfile and has a title in the headerbar
class ExplanationWidget extends StatefulWidget {
  /// Creates a Widget, that displays a markdown file with title in the AppBar

  /// the markdown text to display
  final String tutorialText;

  /// the title to display in the AppBar
  final String title;

  const ExplanationWidget({
    required this.title,
    required this.tutorialText,
    super.key,
  });

  @override
  State<ExplanationWidget> createState() => _ExplanationWidgetState();
}

class _ExplanationWidgetState extends State<ExplanationWidget> {
  @override
  Widget build(BuildContext context) {
    // the Page contains a normal scaffold app
    return Scaffold(
      // with a custom AppBar
      appBar: AppBar(
        // containing the matching hero of the [ReferencePage] Button
        title: Hero(
          tag: widget.title, // ensures the button label and the title are linked
          // this wrapper ensures the textstyle of the label is kept during the animation
          child: Material(
            color: Colors.transparent,
            child: Text(widget.title), // the visible content of the AppBar is a label with the title of the Page
          ),
        ),
      ),
      // the Body of the Page
      body: Container(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context)
                .size
                .width), // this is necessary as Markdown widgets are Scrollable and they cant have infinite space along their nonscrolling axis
        // this widget actually renders the Markdowntext beautifully
        child: Markdown(
          imageDirectory: "data/images/", // an image like this ![cat.png] is located at ithkuilingo/data/images/cat.png
          data: widget.tutorialText,
        ),
      ),
    );
  }
}
