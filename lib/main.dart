import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.

  GlobalKey key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(key: key, title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({key, required this.title});

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
    Get.put(ChipController());
    return GetBuilder(builder: (ChipController controller) {
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
                children: controller.lstType
                    .map((text) => ChoiceChip(
                          selected: controller.selectedChipAData == text,
                          label: Text(text,
                              style: const TextStyle(color: Colors.white)),
                          elevation: 3,
                          pressElevation: 5,
                          backgroundColor: Colors.grey[400],
                          selectedColor: Colors.lightGreen,
                          onSelected: (bool selected) {
                            if (selected) {
                              controller.setSelectedData(text);
                            }
                          },
                        ))
                    .toList(),
              ),
              const Text('Select B value'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: controller.lstLanguage
                    .map((text) => ChoiceChip(
                          selected: controller.selectedChipBData == text,
                          label: Text(text,
                              style: const TextStyle(color: Colors.white)),
                          elevation: 3,
                          pressElevation: 5,
                          backgroundColor: Colors.grey[400],
                          selectedColor: Colors.lightGreen,
                          onSelected: (bool selected) {
                            if (selected) {
                              controller.setSelectedChipBData(text);
                            }
                          },
                        ))
                    .toList(),
              ),
              ElevatedButton(
                child:
                    const Text('Pass selected A and B values to next screen'),
                onPressed: () {
                  print(controller.selectedChipAData);
                  print(controller.selectedChipBData);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

class ChipController extends GetxController {
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
    update();
  }

  void setSelectedChipBData(String data) {
    selectedChipBData = data;
    update();
  }
}
