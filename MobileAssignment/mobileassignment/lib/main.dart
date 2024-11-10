import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, String>> items = [];
  List<int> fibonacciList = [];
  List<Map<String, String>> selectedCircleItems = [];
  List<Map<String, String>> selectedSquareItems = [];
  List<Map<String, String>> selectedXItems = [];

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
        'Index': '$i',
        'Number': '$fNumber',
        'c': '$c',
      });
    }
    setState(() {});
  }

  bool _isBottomSheetVisible = false;

  void _showBottomSheet(BuildContext context, String tappedC) {
    setState(() {
      _isBottomSheetVisible = true;
    });

    print("tappedC: $tappedC");
    List<Map<String, String>> tappedItems;
    if (tappedC == '0') {
      tappedItems = selectedCircleItems;
    } else if (tappedC == '1') {
      tappedItems = selectedSquareItems;
    } else {
      tappedItems = selectedXItems;
    }

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
                  itemCount: tappedItems.length,
                  itemBuilder: (context, index) {
                    var item = tappedItems[index];
                    return Container(
                      margin: const EdgeInsets.only(
                          left: 10.0, top: 20.0, right: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          try {
                            String siToAdd = item['Index'] ?? '';
                            int indexToAdd = int.parse(siToAdd);
                            if (kDebugMode) {
                              print("siToAdd: $siToAdd");
                              print("indexToAdd : $indexToAdd ");
                            }
                            tappedItems.remove(item);
                            items.insert(indexToAdd, item);
                            setState(() {});
                            Navigator.pop(context);
                          } catch (e) {
                            if (kDebugMode) print('Exception: $e');
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'Index: ${item['Index']}, Number: ${item['Number']}',
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
                    child: GestureDetector(
                      onTap: () {
                        if (kDebugMode) {
                          print(
                              "_isBottomSheetVisible: $_isBottomSheetVisible");
                        }
                        try {
                          if (!_isBottomSheetVisible) {
                            String tappedC = item['c'] ?? '';
                            if (tappedC == '0') {
                              selectedCircleItems.add(item);
                              selectedCircleItems.sort((a, b) => int.parse(a['Index']!).compareTo(int.parse(b['Index']!)));
                            } else if (tappedC == '1') {
                              selectedSquareItems.add(item);
                              selectedSquareItems.sort((a, b) => int.parse(a['Index']!).compareTo(int.parse(b['Index']!)));
                            } else {
                              selectedXItems.add(item);
                              selectedXItems.sort((a, b) => int.parse(a['Index']!).compareTo(int.parse(b['Index']!)));
                            }
                            items.removeAt(index);
                            setState(() {});
                            _showBottomSheet(context, tappedC);
                          }
                        } catch(e) {
                          if (kDebugMode) print('Exception: $e');
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              'Index: ${item['Index']}, Number: ${item['Number']}',
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
