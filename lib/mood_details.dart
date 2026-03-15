import 'package:flutter/material.dart';
import 'package:my_app/model/mood_entry.dart';

class MoodDetails extends StatefulWidget {
  final MoodEntry entry;

  const MoodDetails({super.key, required this.entry});

  @override
  State<MoodDetails> createState() => _MoodDetailsState();
}

class _MoodDetailsState extends State<MoodDetails> {
  @override
  Widget build(BuildContext context) {

    final entry = widget.entry;

    return Scaffold(
      appBar: AppBar(
        title: Text("Mood Details", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 103, 80, 164),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop(); // Goes back to the previous page
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 40,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Date: ${entry.year} ${entry.month} ${entry.day}, ${entry.time}", style: TextStyle(fontSize: 18)),
            Text("Name: ${entry.name}", style: TextStyle(fontSize: 18)),
            if (entry.nickname != null && entry.nickname != "") // Doesn't show the nickname if there is none
              Text("Nickname: ${entry.nickname}", style: TextStyle(fontSize: 18)),
            Text("Age: ${entry.age}", style: TextStyle(fontSize: 18)),
            Text(entry.exercisedToday ? "Exercise day!" : "Rest day!", style: TextStyle(fontSize: 18)),
            Text("Emotion: ${entry.emotion} (${entry.emotionIntensity}/10)", style: TextStyle(fontSize: 18)),
            Text("Weather: ${entry.weather}", style: TextStyle(fontSize: 18)),
            FilledButton(
              child: Text('Back'),
              onPressed: () {
                Navigator.of(context).pop(); // Goes back to the previous page
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 103, 80, 164)
              )
            )
          ],
        ),
      ),
    );
  }
}