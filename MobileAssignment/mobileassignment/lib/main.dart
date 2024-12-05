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
  List<Map<String, String>> selectedItems = [];
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
  int recentIndex = -1;
  void _showBottomSheet(BuildContext context, String tappedC) {
    setState(() {
      _isBottomSheetVisible = true;
    });

    if (kDebugMode) {
      print("tappedC: $tappedC");
    }
    List<Map<String, String>> filteredItems = selectedItems.where((item) {
      String c = item['c'] ?? '';
      return c == tappedC;
    }).toList();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          decoration: const BoxDecoration(
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
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    var item = filteredItems[index];
                    return Container(
                      child: GestureDetector(
                          onTap: () {
                            try {
                              String siToAdd = item['Index'] ?? '';
                              int indexToAdd = int.parse(siToAdd);
                              if (kDebugMode) {
                                print("siToAdd: $siToAdd");
                                print("indexToAdd : $indexToAdd ");
                                print("_isBottomSheetVisible: $_isBottomSheetVisible");
                                print("index: $index recentIndex: $recentIndex");
                              }
                              selectedItems.remove(item);
                              items.insert(indexToAdd, item);
                              items.sort((a, b) => int.parse(a['Index']!).compareTo(int.parse(b['Index']!))); //ascending order
                              recentIndex = int.parse(item['Index']!); //recently returned index
                              setState(() {});
                              Navigator.pop(context);
                            } catch (e) {
                              if (kDebugMode) print('Exception: $e');
                            }
                          },
                          child: Container(
                            color: int.parse(item['Index'] ?? '')== recentIndex ? Colors.green : Colors.transparent,
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Text(
                                    'Index: ${item['Index']}, Number: ${item['Number']}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 20),
                                      child: ConditionalContainer(cValue: item['c'].toString()),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
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
                    child: GestureDetector(
                        onTap: () {
                          if (kDebugMode) {
                            print("_isBottomSheetVisible: $_isBottomSheetVisible");
                            String itemCurIndex = item['Index'] ?? '';
                            print("itemCurIndex: $itemCurIndex");
                            print("index: $index recentIndex: $recentIndex");
                          }
                          try {
                            if (!_isBottomSheetVisible) {
                              String tappedC = item['c'] ?? '';
                              selectedItems.add(item);
                              selectedItems.sort((a, b) => int.parse(a['Index']!).compareTo(int.parse(b['Index']!))); //ascending order
                              items.removeAt(index);
                              recentIndex = int.parse(item['Index']!); //recently added index
                              setState(() {});
                              _showBottomSheet(context, tappedC);
                            }
                          } catch (e) {
                            if (kDebugMode) print('Exception: $e');
                          }
                        },
                        child: Container(
                          color: int.parse(item['Index']!) == recentIndex ? Colors.red : Colors.transparent,
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Text(
                                  'Index: ${item['Index']}, Number: ${item['Number']}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 20),
                                    child: ConditionalContainer(cValue: item['c'].toString()),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
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