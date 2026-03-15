import 'package:flutter/material.dart';
import 'package:my_app/model/mood_entry.dart';

class MoodEntryList with ChangeNotifier{

  final List<MoodEntry> _entries = [];

  List<MoodEntry> get entries => _entries;

  void addEntry(DateTime dateTime, String name, String nickname, int age, bool exercisedToday, String emotion, double emotionIntensity, String weather) {
    _entries.add(MoodEntry(dateTime, name, nickname, age, exercisedToday, emotion, emotionIntensity, weather));
    notifyListeners();
  }

  void removeEntry(int i){
    _entries.removeAt(i);
    notifyListeners();
  }
}