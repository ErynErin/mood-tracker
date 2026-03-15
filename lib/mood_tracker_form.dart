import 'package:flutter/material.dart';
import 'package:my_app/my_drawer.dart';
import 'package:my_app/provider/mood_entry_list.dart';
import 'package:provider/provider.dart';

class MoodTrackerForm extends StatefulWidget {
  const MoodTrackerForm({super.key});

  @override
  State<MoodTrackerForm> createState() => _MoodTrackerFormState();
}

class _MoodTrackerFormState extends State<MoodTrackerForm> {
  final _formKey = GlobalKey<FormState>();
  static final List<String> _emotions = [ "Joy", "Sadness", "Disgust", "Fear", "Anger", "Anxiety", "Embarrassment", "Envy" ];
  static final List<String> _weathers = [ "Sunny", "Rainy", "Stormy", "Hailing", "Snowy", "Cloudy", "Foggy", "Partly Cloudy" ];

  // The default contents of the form
  Map<String, dynamic> moodValues = {
    'name': '',
    'nickname': '',
    'age': 0,
    'exercisedToday': true, // default on
    'exercisedTodayText': 'Exercise Day!',
    'emotion': _emotions.first, // default Joy
    'emotionIntensity': 5.0, // default
    'weather': _weathers.first, // default Sunny
  };

  bool _isVisible = false; // Flag to control the summary's visibility
  Map<String, dynamic> savedValues = {}; // Values when the form is saved

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 103, 80, 164),
        title: Text('Exercise 5', style: TextStyle(color: Colors.white)),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(22.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          child: Column(
            spacing: 16.0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Title
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text("Mood Tracker", style: TextStyle(
                  fontSize: 30, 
                  fontWeight: FontWeight.bold, 
                  color: const Color.fromARGB(255, 103, 80, 164))),
              ),

              // Name (text field) (required)
              buildNameTextField(),

              // Nickname (text field) (optional)
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  prefixIcon: Icon(Icons.auto_awesome_rounded),
                  hintText: 'Nickname (optional)',
                  labelText: 'Nickname',
                ),

                onSaved: (String? value) {
                    setState(() {
                      moodValues['nickname'] = value;
                    });
                }
              ),

              // Age and Exercised Today in one row
              Row( 
                children: [
                  // Age (text field) (required)
                  Expanded(child: buildAgeTextField()),

                  // Exercised Today (switch)
                  Expanded(child: SwitchListTile(
                    title: Text("Exercised today"),
                    value: moodValues['exercisedToday'],
                    onChanged: (value) {
                      setState(() {
                        moodValues['exercisedToday'] = value;
                        if(value) { // If true, exercise day
                          moodValues['exercisedTodayText'] = 'Exercise Day!';
                        } else { // If false, rest day
                          moodValues['exercisedTodayText'] = 'Rest Day!';
                        }
                      });
                    }
                  ))
                ],
              ),

              // Current Emotion (radio)
              Text('What emotion are you feeling today?', style: TextStyle(fontSize: 17)),
              RadioGroup<String>(
                groupValue: moodValues['emotion'],
                onChanged: (String? value) {
                  setState(() {
                    moodValues['emotion'] = value;
                  });
                },
                child: buildEmotionRadioButtons(),
              ),

              // Emotion Intensity (slider)
              Text('How strong do you feel this emotion?', style: TextStyle(fontSize: 17)),
              buildEmotionSlider(),

              // Weather (dropdown)
              Text('Weather Today', style: TextStyle(fontSize: 17)),
              buildWeatherDropdown(),

              // Save and Reset buttons
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20.0,
                  children: [
                  buildSaveButton(), // Save button
                  buildResetButton() // Reset button
                ])
              ),

              // Summary text
              if (_isVisible)
                if (savedValues['nickname'] == '') // Doesn't show the nickname
                  Text('Name: ${savedValues['name']}\nAge: ${savedValues['age']}\n${savedValues['exercisedTodayText']}\nEmotion: ${savedValues['emotion']}\nEmotion Strength: ${savedValues['emotionIntensity'].toString()}/10\nWeather: ${savedValues['weather']}')
                else // // Shows the nickname
                  Text('Name: ${savedValues['name']}\nNickname: ${savedValues['nickname']}\nAge: ${savedValues['age']}\n${savedValues['exercisedTodayText']}\nEmotion: ${savedValues['emotion']}\nEmotion Strength: ${savedValues['emotionIntensity'].toString()}/10\nWeather: ${savedValues['weather']}'),

            ],
          ),
        )
      )
    );
  }

  TextFormField buildNameTextField(){
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(Icons.auto_awesome_rounded),
        hintText: 'Name',
        labelText: 'Name'
      ),

      validator: (String? value) {
        // Checks if the value is null or empty
        if (value == null || value.isEmpty) {
          return "Please enter a name";
        }
        return null;
      },

      onSaved: (String? value) {
          setState(() {
            moodValues['name'] = value;
          });
      },
    );
  }

  TextFormField buildAgeTextField(){
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(Icons.auto_awesome_rounded),
        hintText: 'Age',
        labelText: 'Age',
      ),

      onChanged: (String value) {
        setState(() {
          moodValues['age'] = int.tryParse(value) ?? 0;
        });
      },

      validator: (String? value){
        // Checks if the value is null, empty, not a number, or less than 0
        if (value == null || value.isEmpty || int.tryParse(value) == null || int.parse(value) < 0) {
          return "Please enter a valid age";
        }
        return null;
      },

      onSaved: (String? value) {
        setState(() {
          // Try to parse the value as an integer, if not, default to 0
          moodValues['age'] = int.tryParse(value ?? '0') ?? 0;
        });
      },
    );
  }

  RadioGroup<String> buildEmotionRadioButtons() {
  return RadioGroup<String>(
      groupValue: moodValues['emotion'],
      onChanged: (String? value) {
        moodValues['emotion'] = value;
      },
      child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // left column
      Expanded(child: buildEmotionColumn(0, 4)),
      // right column
      Expanded(child: buildEmotionColumn(4, 8)),
    ],
  ));
  }

  Column buildEmotionColumn(int start, int end) {
    return Column(
      children: [
        for (int i = start; i < end; i++)
          RadioListTile<String>(
            title: Text(_emotions[i]),
            value: _emotions[i],
            groupValue: moodValues['emotion'], 
            onChanged: (String? value) {
              setState(() {
                moodValues['emotion'] = value;
              });
            },
          ),
      ],
    );
  }

  FormField<double> buildEmotionSlider(){
    return FormField<double>(
      initialValue: 5.0,
      builder: (FormFieldState<double> state) {
        return Slider(
      value: (moodValues['emotionIntensity'] ?? 5.0).toDouble(),
      max: 10,
      divisions: 10,
      label: moodValues['emotionIntensity'].toString(),

      onChanged: (double value) {
        state.didChange(value);
        setState(() {
          moodValues['emotionIntensity'] = value;
        });
      });
      },

      onSaved: (newValue) {
        setState(() {
          moodValues['emotionIntensity'] = newValue;
        });
      },
    );
  }

  DropdownButtonFormField<String> buildWeatherDropdown(){
    return DropdownButtonFormField<String>(
      initialValue: moodValues['weather'],
      items: _weathers.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
      ).toList(),

      onChanged: (String? value) {
        setState(() {
          moodValues['weather'] = value;
        });
      },

      onSaved: (newValue) {
        setState(() {
          moodValues['weather'] = newValue;
        });
      },
    );
  }

  bool isDuplicate() { // Finds if there is a duplicate or an exact replica
  return context.read<MoodEntryList>().entries.any((entry) =>
    entry.name == moodValues['name'] &&
    entry.nickname == moodValues['nickname'] &&
    entry.age == moodValues['age'] &&
    entry.exercisedToday == moodValues['exercisedToday'] &&
    entry.emotion == moodValues['emotion'] &&
    entry.emotionIntensity == moodValues['emotionIntensity'] &&
    entry.weather == moodValues['weather']);
}

  ElevatedButton buildSaveButton(){
    return ElevatedButton(
      child: Text("Save"),
      onPressed: () async {
        // Missing fields alert
        if (!_formKey.currentState!.validate()) {
          await _showMyDialog("There are empty or invalid required fields.");
          return;
        }  

        _formKey.currentState!.save();

        // Duplicate input alert if there is a duplicate
        if (isDuplicate()) {
          await _showMyDialog("Mood entry already exists.");
          return; 
        }

        // Only shows the summary if the form is successfully validated
        setState((){
          savedValues = Map.from(moodValues); // Copies moodValues to savedValues
          _isVisible = true; // Shows the summary text

          // Adds the entry to the list of entries
          context.read<MoodEntryList>().addEntry(
            DateTime.now(),
            savedValues['name'],
            savedValues['nickname'],
            savedValues['age'],
            savedValues['exercisedToday'],
            savedValues['emotion'],
            savedValues['emotionIntensity'],
            savedValues['weather']
          );
        });
        await _showMyDialog("Successfully saved!");
      }
    );
  }

  ElevatedButton buildResetButton(){
    return ElevatedButton(
      child: Text("Reset"),
      onPressed: () {
        _formKey.currentState!.reset();
        setState((){ 
          // Resets moodValues to the default values
          moodValues = {
            'name': '',
            'nickname': '',
            'age': 0,
            'exercisedToday': true, // default on
            'exercisedTodayText': 'Exercise Day!',
            'emotion': _emotions.first, // default Joy
            'emotionIntensity': 5.0, // default
            'weather': _weathers.first, // default Sunny
          };
          _isVisible = false; // Hides the summary text
        });
      }
    );
  }

  // https://api.flutter.dev/flutter/material/AlertDialog-class.html
  Future<void> _showMyDialog(String notification) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 20.0),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(notification)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
