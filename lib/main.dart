import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:io';
import 'lib.dart';

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

  @override
  void initState() {
    tutorials = readDir(dirTutorials);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: colorBackground,
        appBar: AppBar(
          backgroundColor: colorDefaultLight,
          title: const Center(child: CText("Ithkuil is fun!")),
        ),
        body: Container(
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
            const Center(
              child: CText("Homepage"),
            ),

            /// The Tutorials Page
            TutorialsWidget(tutorials),
            const Center(
              child: CText("Progress"),
            ),
            const Center(
              child: CText("Reading"),
            ),
          ][currentPageIndex],
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          backgroundColor: colorDefaultLight,
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
