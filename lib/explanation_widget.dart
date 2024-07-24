import 'package:flutter/material.dart';
import 'lib.dart';
import 'package:flutter_markdown/flutter_markdown.dart';


/// Creates a Widget, that displays a markdown file with title in the AppBar
class ExplanationWidget extends StatefulWidget {
  final String tutorialText;
  final String title;

  const ExplanationWidget(
    this.title,
    this.tutorialText, {
    super.key,
  });

  @override
  State<ExplanationWidget> createState() => _ExplanationWidgetState();
}

class _ExplanationWidgetState extends State<ExplanationWidget> {
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
