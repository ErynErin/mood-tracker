import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  List<Map<String, dynamic>> routes = [
    {"route": "/form", "page": "Add a Mood"},
    {"route": "/entries", "page": "Mood Entries"},
  ];

  @override
  Widget build(BuildContext context) {
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    return Drawer(
      child: Column(children: [
        Container(
          width: double.infinity,
          color: const Color.fromARGB(255, 103, 80, 164),
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 25.0, bottom: 25.0),
          child: Text(
            "Mood Tracker",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      
        Expanded(child: ListView.builder(
          itemCount: routes.length,
          itemBuilder: (ctx, i){
            return ListTile(
              // Checks if the current route is the same as the ListTile
              selected: currentRoute == routes[i]["route"], 
              
              selectedTileColor: const Color.fromARGB(255, 233, 227, 245),
              selectedColor: const Color.fromARGB(255, 103, 80, 164),

              title: Text(routes[i]["page"]!),
              onTap: () {
                Navigator.pushNamed(
                  context, routes[i]["route"]!
                );
              }
            );
          }
        ))

      ])
    );
  }
}