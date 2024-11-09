import 'package:flutter/material.dart';

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
  // List to hold the items
  List<Map<String, String>> items = [];
  List<int> fibonacciList = [];

  // Populate the list when the widget is initialized
  @override
  void initState() {
    super.initState();
    _addItems(); // Call the function to add items to the list
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
    setState(() {
      // Trigger UI rebuild after the list is populated
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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

class ConditionalContainer extends StatelessWidget {
  final String cValue;

  ConditionalContainer({required this.cValue});

  @override
  Widget build(BuildContext context) {
    if (cValue == "0") {
      return Container(
          width: 20.0,
          height: 20.0,
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ));
    } else if (cValue == "1") {
      return Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              )));
    } else {
      return Container(
        width: 20.0,
        height: 20.0,
        alignment: Alignment.center,
        child: const Text(
          'X',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      );
    }
  }
}
