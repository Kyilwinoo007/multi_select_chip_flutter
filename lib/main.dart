import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChipProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(key: key, title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? data;
  @override
  void initState() {
    setData();
    super.initState();
  }

  void setData() {
    this.data = "Hello Widget";
  }

  void getData() {
    print(data!.length);
  }

  @override
  Widget build(BuildContext context) {
    final chipProvider = Provider.of<ChipProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Select A value'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: chipProvider.lstType
                  .map((text) => ChoiceChip(
                        selected: chipProvider.selectedChipAData == text,
                        label: Text(text,
                            style: const TextStyle(color: Colors.white)),
                        elevation: 3,
                        pressElevation: 5,
                        backgroundColor: Colors.grey[400],
                        selectedColor: Colors.lightGreen,
                        onSelected: (bool selected) {
                          if (selected) {
                            chipProvider.setSelectedData(text);
                          }
                        },
                      ))
                  .toList(),
            ),
            const Text('Select B value'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: chipProvider.lstLanguage
                  .map((text) => ChoiceChip(
                        selected: chipProvider.selectedChipBData == text,
                        label: Text(text,
                            style: const TextStyle(color: Colors.white)),
                        elevation: 3,
                        pressElevation: 5,
                        backgroundColor: Colors.grey[400],
                        selectedColor: Colors.lightGreen,
                        onSelected: (bool selected) {
                          if (selected) {
                            chipProvider.setSelectedChipBData(text);
                          }
                        },
                      ))
                  .toList(),
            ),
            ElevatedButton(
              child: const Text('Pass selected A and B values to next screen'),
              onPressed: () {
                print(chipProvider.selectedChipAData);
                print(chipProvider.selectedChipBData);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChipProvider extends ChangeNotifier {
  String? selectedChipAData;
  String? selectedChipBData;
  List<String> lstType = [
    "Regular",
    "Hard Sleeper",
    "Soft Sleeper",
  ];
  List<String> lstLanguage = [
    "Python",
    "Flutter",
  ];
  void setSelectedData(String data) {
    selectedChipAData = data;
    notifyListeners();
  }

  void setSelectedChipBData(String data) {
    selectedChipBData = data;
    notifyListeners();
  }
}
