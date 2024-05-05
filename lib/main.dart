import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_app/addingcomponentsdialog.dart';
import 'package:smart_home_app/commandhandler.dart';
import 'package:smart_home_app/databaseconnector.dart';
import 'package:smart_home_app/electroniccomponentcontrol.dart';
import 'package:smart_home_app/firebase_options.dart';
import 'package:smart_home_app/localdatastorage.dart';
import 'package:smart_home_app/space.dart';

DatabaseConnector databaseConnector = DatabaseConnector('test');
LocalDataStorage localDataStorage = LocalDataStorage("data.json");
List<Space> spaces = [];
CommandHandler commandHandler = CommandHandler(spaces);
ElectronicComponentConrol electronicComponentConrol =
    ElectronicComponentConrol(spaces);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Обязательно для Flutter
  spaces = await localDataStorage.loadData();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  databaseConnector.init();
  await commandHandler.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart home'),
        leading: commandHandler.getView(setState, context),
      ),
      body: ListView.builder(
        itemCount: spaces.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: TextButton(
              child: Text(spaces[index].name),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(spaces[index]),
                  ),
                );
              },
            ),
            trailing: PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry>[
                  PopupMenuItem(
                    value: 1,
                    onTap: () {
                      setState(() {
                        spaces.remove(spaces[index]);
                        localDataStorage.saveData(spaces);
                      });
                    },
                    child: const Text('Delete'),
                  ),
                ];
              },
              icon: const Icon(Icons.more_vert),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add_space_button',
        onPressed: () {
          _showAddSpace(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddSpace(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add new space"),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: "Name"),
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Add"),
              onPressed: () {
                String name = nameController.text.trim();
                if (name.isNotEmpty) {
                  setState(() {
                    spaces.add(Space(name: name));
                    localDataStorage.saveData(spaces);
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class DetailScreen extends StatefulWidget {
  Space space;

  DetailScreen(this.space, {Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Space get space => widget.space;
  late AddingComponentDialogs addingComponentDialogs;

  @override
  void initState() {
    super.initState();
    electronicComponentConrol.ChangeStateSetter(setState);
    addingComponentDialogs = AddingComponentDialogs(space.electronicComponents);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Component Details'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // Количество столбцов
          crossAxisSpacing: 8.0, // Пространство между столбцами
          mainAxisSpacing: 8.0, // Пространство между строками
          childAspectRatio: 0.8,
        ),
        itemCount: space.electronicComponents.length,
        itemBuilder: (context, index) {
          return space.electronicComponents[index].informationView
              .getView(setState);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return addingComponentDialogs.showDialog(setState, context);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
