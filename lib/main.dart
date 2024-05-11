import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:ithkuilingo/custom_keyboard.dart';
import 'lib.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  late LinkedHashMap<String, String> tutorials;
  int currentPageIndex = 0;
  CKeyboard keyboard = CKeyboard();
  bool keyboardVisible = false;
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CTextField newTextField() {
    return CTextField(
      onFocussed: (controller) {
        widget.keyboard.setController(controller);
        print(widget.keyboard.controller);
        setState(() {
          widget.keyboardVisible = true;
        });
      },
      onUnfocussed: () {
        setState(() {
          // widget.keyboardVisible = false;
        });
      },
    );
  }

  @override
  void initState() {
    widget.tutorials = readDir(dirTutorials);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ithkuilingo",
      theme: ThemeData(
        colorScheme: const ColorScheme(
          onSurface: colorText,
          brightness: Brightness.light,
          primary: colorDefault,
          onPrimary: colorText,
          secondary: colorDefaultLight,
          onSecondary: colorText,
          error: colorError,
          onError: colorText,
          background: colorBackground,
          onBackground: colorText,
          surface: colorDefaultLight,
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: colorBackground,
        appBar: AppBar(
          backgroundColor: colorDefaultLight,
          title: const Center(
              child: CText(
            "Ithkuil is fun!",
            style: textStyleHeading,
          )),
        ),
        body: Stack(
          children: [
            /// The main UI
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(
                    width: 15,
                    color: colorBackground,
                  ),
                  right: BorderSide(
                    width: 15,
                    color: colorBackground,
                  ),
                ),
              ),
              child: [
                /// The Home Page
                Column(
                  children: [
                    CText("Homepage"),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          widget.keyboardVisible = !widget.keyboardVisible;
                        });
                      },
                      child: CText("Press Me!"),
                    ),
                    newTextField(),
                  ],
                ),

                /// The Tutorials Page
                TutorialsWidget(widget.tutorials),
                const Center(
                  child: CText("Progress"),
                ),
                const Center(
                  child: CText("Reading"),
                ),
              ][widget.currentPageIndex],
            ),

            /// The Keyboard
            Container(
              alignment: Alignment.bottomLeft,
              child: Visibility(
                visible: widget.keyboardVisible,
                child: CKeyboard(),
              ),
            )
          ],
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (index) {
            setState(() {
              widget.currentPageIndex = index;
            });
          },
          backgroundColor: colorDefaultLight,
          indicatorColor: colorDefault,
          selectedIndex: widget.currentPageIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: "Home",
              selectedIcon: Icon(Icons.home),
            ),
            NavigationDestination(
              icon: Icon(Icons.school_outlined),
              label: "Learn",
              selectedIcon: Icon(Icons.school),
            ),
            NavigationDestination(
              icon: Icon(Icons.assessment_outlined),
              label: "Progress",
              selectedIcon: Icon(Icons.assessment),
            ),
            NavigationDestination(
              icon: Icon(Icons.local_library_outlined),
              label: "Reading",
              selectedIcon: Icon(Icons.local_library),
            )
          ],
        ),
      ),
    );
  }
}
