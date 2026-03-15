import 'package:flutter/material.dart';
import 'package:my_app/mood_tracker_form.dart';
import 'package:my_app/mood_entry_page.dart';
import 'package:my_app/provider/mood_entry_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MoodEntryList()
        )
      ], 
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/entries",
      routes: {
        "/form": (context) => MoodTrackerForm(),
        "/entries": (context) => MoodEntryPage()
      }
    );
  }
}