import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_app/MC/mcboard.dart';
import 'package:smart_home_app/MC/mctemplates.dart';
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
  List<McBoard> addedBoards = List.empty(growable: true);

  bool boardContainsInAdd(int id) {
    for (int i = 0; i < addedBoards.length; i++) {
      if (addedBoards[i].id == id) {
        return true;
      }
    }
    return false;
  }

  Widget addMCWidget(McBoard mcboard, StateSetter state) {
    return ElevatedButton.icon(
      onPressed: () {
        state(() {
          addedBoards.add(mcboard.clone());
        });
      },
      icon: const Icon(Icons.add),
      label: const Text("Add"),
    );
  }

  Widget removeMCWidget(McBoard mcboard, StateSetter state) {
    return ElevatedButton.icon(
      onPressed: () {
        state(() {
          for (int i = 0; i < addedBoards.length; i++) {
            if (mcboard.id == addedBoards[i].id) {
              addedBoards.remove(addedBoards[i]);
            }
          }
        });
      },
      icon: const Icon(Icons.remove),
      label: const Text("Remove"),
    );
  }

  Widget widgetByMcState(McBoard mcboard, StateSetter state) {
    if (boardContainsInAdd(mcboard.id)) {
      return removeMCWidget(mcboard, state);
    }
    return addMCWidget(mcboard, state);
  }

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
          title: const Text("Add new space", textAlign: TextAlign.center),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(labelText: "Name"),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "MC:",
                        style: TextStyle(fontSize: 20),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: boards.length,
                        itemBuilder: (context, index) {
                          return ExpansionTile(
                            trailing: widgetByMcState(boards[index], setState),
                            title: Text(boards[index].name),
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    if (boards[index].iconPath.isNotEmpty)
                                      Container(
                                        height: 256,
                                        width: 256,
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                boards[index].iconPath),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    Text(
                                      boards[index].description,
                                      style: const TextStyle(fontSize: 14),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
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
                    spaces.add(Space(name: name, boards: addedBoards));
                    localDataStorage.saveData(spaces);
                    Navigator.of(context).pop();
                  });
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
    addingComponentDialogs = AddingComponentDialogs(space);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Component Details'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
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
              return addingComponentDialogs.showElectronicComponentDialog(
                  setState, context);
            },
          ); 
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
