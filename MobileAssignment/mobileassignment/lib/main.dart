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
          brightness: Brightness.light,  // Set to dark theme if black is preferred
          primary: Colors.white,
          onPrimary: Colors.white,  // Text or icon color on primary color
          secondary: Colors.white,  // Optional, customize secondary color
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

  // Populate the list when the widget is initialized
  @override
  void initState() {
    super.initState();
    _addItems();  // Call the function to add items to the list
  }

  void _addItems() {
    // Example: Loop to add 10 items
    for (int i = 1; i <= 10; i++) {
      items.add({
        'text': 'Item $i',
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
                itemCount: 10,
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
                            item['text'] ?? '',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        // Image on the right side
                        Image.network(
                          item['image'] ?? '',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
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
