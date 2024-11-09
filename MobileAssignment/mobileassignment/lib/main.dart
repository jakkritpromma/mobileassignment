import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/*final List<Map<String, String>> items = [
  {'text': 'Item 1', 'image': 'https://via.placeholder.com/50'},
  {'text': 'Item 2', 'image': 'https://via.placeholder.com/50'},
  {'text': 'Item 3', 'image': 'https://via.placeholder.com/50'},
  {'text': 'Item 4', 'image': 'https://via.placeholder.com/50'},
  {'text': 'Item 5', 'image': 'https://via.placeholder.com/50'},
];*/

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          // Set to dark theme if black is preferred
          primary: Colors.white,
          onPrimary: Colors.white,
          // Text or icon color on primary color
          secondary: Colors.white,
          // Optional, customize secondary color
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
      c++;
      if (c == 3) c = 0;

      int fNumber = fibonacciList[i];
      items.add({
        'Index': 'Index: $i',
        'Number': 'Number: $fNumber',
        'image': 'https://via.placeholder.com/150/0000FF/808080?text=Item+$i',
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Text on the left side
                        Expanded(
                          child: Text(
                            item['Index'].toString() + ", " + item['Number'].toString(),
                            //semanticsLabel: item['Number'] ?? '',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        // Image on the right side
                        Container(
                          width: 20.0,
                          // Width of the square
                          height: 20.0,
                          // Height of the square (same as width for a square)
                          decoration: BoxDecoration(
                            color: Colors.white, // White background
                            border: Border.all(
                              color: Colors.black, // Black border
                              width: 2.0, // Border width
                            ),
                          ),
                        ),
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
