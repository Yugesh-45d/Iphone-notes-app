// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/datas/note_data.dart';
import 'package:notes/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return const CupertinoApp(
    //   debugShowCheckedModeBanner: false,
    //   title: "Notes",
    //   theme: CupertinoThemeData(brightness: Brightness.light),
    //   home: HomePage(),
    // );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NoteData(),
          builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Notes",
            theme: ThemeData(
              brightness: Brightness.light,
              useMaterial3: true,
            ),
            home: HomePage(),
          ),
        ),
      ],
    );
  }
}
