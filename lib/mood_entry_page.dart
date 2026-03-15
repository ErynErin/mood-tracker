import 'package:flutter/material.dart';
import 'package:my_app/my_drawer.dart';
import 'package:my_app/mood_details.dart';
import 'package:my_app/provider/mood_entry_list.dart';
import 'package:provider/provider.dart';

class MoodEntryPage extends StatefulWidget {
  const MoodEntryPage({super.key});

  @override
  State<MoodEntryPage> createState() => _MoodEntryPageState();
}

class _MoodEntryPageState extends State<MoodEntryPage> {

  @override
  Widget build(BuildContext context) {
  var entries = context.watch<MoodEntryList>().entries;
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 103, 80, 164),
        title: Text('Mood Entries', style: TextStyle(color: Colors.white)),
      ),

      body: 
        entries.length == 0 ? Center(child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Text("No entries. Try adding some!", style: TextStyle(fontSize: 20),), 
            FilledButton(
              child: Text('Add Entry'),
              onPressed: () {
                Navigator.pushNamed(context, "/form");  
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 103, 80, 164)
              )
            )
          ]
        )):
        ListView.builder(
          itemCount: entries.length,
          itemBuilder: (context, i) {
            return ListTile(
              title: Text('${entries[i].name} - ${entries[i].year} ${entries[i].month} ${entries[i].day}, ${entries[i].time}'),
              trailing: IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: () {
                  // Delete the mood entry
                  context.read<MoodEntryList>().removeEntry(i);
                }
              ),
              onTap: () {
                // Go to the details page for a mood entry
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MoodDetails(entry: entries[i]),
                  ),
                );
              }
            );
          },
        ),
    );
  }
}