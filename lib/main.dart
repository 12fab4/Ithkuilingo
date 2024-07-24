import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:ithkuilingo/custom_keyboard.dart';
import 'package:ithkuilingo/custom_text_input.dart';
import 'package:ithkuilingo/lib.dart';
import 'package:ithkuilingo/reference_page.dart';

// this is boilerplate code that runs our app
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
// end of boilerplate

class _MyAppState extends State<MyApp> {
  /// a title:content association of tutorials for the [ReferencePageWidget]
  late LinkedHashMap<String, String> tutorials;

  /// the currently selected Page/Tab
  int currentTab = 0;

  /// whether the keyboard is shown or not
  bool keyboardVisible = false;

  /// the controller the custom Keyboard uses to communicate with [CTextField]s
  final TextEditingController _controller = TextEditingController();

  /// a function to generate a CTextField that integrates with the keyboard
  CTextField newTextField() {
    // it provides a normal CTextField
    return CTextField(
      // but with a Focusfunction
      onFocused: () {
        setState(() {
          keyboardVisible = true; // that displays the keyboard
        });
        return _controller; // and provides the controller of the keyboard
      },
      // and hides the keyboard if OK is pressed
      onSubmitted: (text) {
        setState(() {
          keyboardVisible = false;
        });
      },
    );
  }

  /// this is called when the Object is not used anymore (when the app is closed)
  @override
  void dispose() {
    _controller
        .dispose(); // and it is required to dispose of [TextEditingController] explicitly (according to some SO guy)
    super.dispose();
  }

  /// this is called when the object enters the object-tree
  @override
  void initState() {
    tutorials = readDir(dirTutorials); // and we use it to read saved data required for propper display
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // we create a basic app
    return MaterialApp(
      title: "Ithkuilingo", // with a title
      // some theming
      theme: ThemeData(
        // a colorscheme
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
        // and some text theming
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 20), // used in Textfields
          labelLarge: TextStyle(fontSize: 20), // used in Buttons
          titleLarge: TextStyle(fontSize: 30), // used in AppBars
        ),
      ),

      // the actual app contains a stack for displaying an inner app with a keyboard ontop
      home: Stack(
        children: [
          // the inner app
          Scaffold(
            // with a header bar
            appBar: AppBar(
              // and a temporary title for now
              title: const Center(
                child: Text("Ithkuil is fun!"),
              ),
            ),
            // a wrapper for the Mainbody to not completely touch the screen edges
            body: Container(
              // this is done using this decoration
              decoration: const BoxDecoration(
                // with these two borders
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
              // child is an Array from which currentPageIndex is selected so it actually returns one Widget even though its an array
              child: [
                // The Home Page - just some experiments TODO implement
                Column(
                  children: [
                    const Text("Homepage"),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          keyboardVisible = !keyboardVisible;
                        });
                      },
                      child: const Text("Press Me!"),
                    ),
                    newTextField(),
                  ],
                ),

                // The reference page
                ReferencePageWidget(
                  tutorials: tutorials,
                ),
                // the Progress page TODO implement
                const Center(
                  child: Text("Progress"),
                ),
                // the reading page TODO implement
                const Center(
                  child: Text("Reading"),
                ),
              ][currentTab], // with this only one element of the array is selected
            ),
            // the footer bar of the inner app
            bottomNavigationBar: NavigationBar(
              // if one switches tabs
              onDestinationSelected: (index) {
                // the corresponding widget is shown via setting currentTab
                setState(() {
                  currentTab = index;
                });
              },
              indicatorColor:
                  colorDefault, // this is necessary as the default highlightcolor is the same as the footer background
              selectedIndex: currentTab,
              // these are the tabs (each has a label and two icons - one if selected and one if not)
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
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
          // this is a Container above the inner app to hide the footer bar if the keyboard is visible
          Container(
            alignment: Alignment.bottomCenter, // the container is at the bottom
            child: Visibility(
              // and only visible
              visible: keyboardVisible, // if the keyboard is visible
              child: Container(
                constraints: const BoxConstraints(
                    maxHeight:
                        80), // the footer bar has a default height of 80 and if no constraints are specified the container fills the screen
                color: colorBackground, // the footer bar is hidden behind a box of backgroundcolor
              ),
            ),
          ),
          // this is the actual keyboard to be shown above the inner app and the footercover
          Container(
            alignment: Alignment.bottomCenter, // the keyboard is also at the bottom
            child: Visibility(
              visible: keyboardVisible, // and only shown if required
              child: CKeyboard(
                controller: _controller, // this is the controller for the keyboard
              ),
            ),
          )
        ],
      ),
    );
  }
}
