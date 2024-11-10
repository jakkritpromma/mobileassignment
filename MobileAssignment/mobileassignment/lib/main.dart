import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'ConditionalContainer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.white,
          onPrimary: Colors.white,
          secondary: Colors.white,
          onSecondary: Colors.white,
          background: Colors.white,
          onBackground: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
          error: Colors.white,
          onError: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/*
   List<int> numbers = [10, 20, 30, 40, 50];

  // Step 1: Identify the index and the item to remove
  int indexToRemove = 2; // Let's say you want to remove the item at index 2 (value 30)
  int item = numbers[indexToRemove]; // Save the item

  // Step 2: Remove the item from the list
  numbers.removeAt(indexToRemove);

  // Step 3: Add the item back at the same original index
  numbers.insert(indexToRemove, item);

  print(numbers); // Output: [10, 20, 30, 40, 50] List<int> numbers = [10, 20, 30, 40, 50];

  // Step 1: Identify the index and the item to remove
  int indexToRemove = 2; // Let's say you want to remove the item at index 2 (value 30)
  int item = numbers[indexToRemove]; // Save the item

  // Step 2: Remove the item from the list
  numbers.removeAt(indexToRemove);

  // Step 3: Add the item back at the same original index
  numbers.insert(indexToRemove, item);

  print(numbers); // Output: [10, 20, 30, 40, 50]
  * */

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, String>> items = [];
  List<int> fibonacciList = [];
  List<Map<int, String>> deletedCircleItems = [];

  @override
  void initState() {
    super.initState();
    _addItems();
  }

  void _addItems() {
    int a = 0, b = 1, c = 0;
    for (int i = 0; i < 40; i++) {
      fibonacciList.add(a);
      int next = a + b;
      a = b;
      b = next;

      int fNumber = fibonacciList[i];
      c = fNumber % 3;
      items.add({
        'Index': 'Index: $i',
        'Number': 'Number: $fNumber',
        'c': '$c',
      });
    }
    setState(() {});
  }

  bool _isBottomSheetVisible = false;

  void _showBottomSheet(BuildContext context) {
    setState(() {
      _isBottomSheetVisible = true;
    });

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    var item = items[index];
                    return Container(
                      margin: const EdgeInsets.only(
                          left: 10.0, top: 20.0, right: 20.0),
                      child:  GestureDetector(
                        //onTap: _onRowClicked,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "${item['Index']}, ${item['Number']}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            ConditionalContainer(cValue: item['c'].toString()),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
    _isBottomSheetVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        titleSpacing: 0,
        centerTitle: true,  
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  var item = items[index];
                  return Container(
                    margin: const EdgeInsets.only(
                        left: 10.0, top: 10.0, bottom: 10.0, right: 20.0),
                    child:  GestureDetector(
                      onTap: () {
                        if (kDebugMode) {
                          print("_isBottomSheetVisible: $_isBottomSheetVisible");
                        }
                        if (!_isBottomSheetVisible ) {
                          _showBottomSheet(context);
                        } else {

                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "${item['Index']}, ${item['Number']}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          ConditionalContainer(cValue: item['c'].toString()),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


