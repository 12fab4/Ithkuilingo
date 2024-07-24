import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:ithkuilingo/custom_keyboard.dart';
import 'package:ithkuilingo/custom_text_input.dart';
import 'package:ithkuilingo/lib.dart';
import 'package:ithkuilingo/reference_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late LinkedHashMap<String, String> tutorials;
  int currentPageIndex = 0;
  bool keyboardVisible = false;
  final TextEditingController _controller = TextEditingController();
  CKeyboard keyboard = const CKeyboard();

  CTextField newTextField() {
    return CTextField(
      onFocussed: () {
        setState(() {
          keyboardVisible = true;
        });

        return _controller;
      },
      onUnfocussed: () {
        // keyboardVisible = false;
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    tutorials = readDir(dirTutorials);
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
                          keyboardVisible = !keyboardVisible;
                        });
                      },
                      child: CText("Press Me!"),
                    ),
                    newTextField(),
                  ],
                ),

                /// The Reference Page
                ReferencePageWidget(tutorials),
                const Center(
                  child: CText("Progress"),
                ),
                const Center(
                  child: CText("Reading"),
                ),
              ][currentPageIndex],
            ),

            /// The Keyboard
            Container(
              alignment: Alignment.bottomCenter,
              child: Visibility(
                visible: keyboardVisible,
                child: CKeyboard(
                  controller: _controller,
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          backgroundColor: colorDefaultLight,
          indicatorColor: colorDefault,
          selectedIndex: currentPageIndex,
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
