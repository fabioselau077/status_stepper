import 'package:flutter/material.dart';
import 'package:status_stepper/status_stepper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Status Stepper Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Status Stepper Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final statuses = List.generate(
    4,
    (index) => SizedBox.square(
      dimension: 32,
      child: Center(child: Text('$index')),
    ),
  );

  int curIndex = -1;
  int lastIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StatusStepper(
                connectorCurve: Curves.easeIn,
                itemCurve: Curves.easeOut,
                activeColor: Colors.amber,
                disabledColor: Colors.grey,
                animationDuration: const Duration(milliseconds: 500),
                children: statuses,
                lastActiveIndex: lastIndex,
                currentIndex: curIndex,
                connectorThickness: 6,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  curIndex = -1;
                  lastIndex = -1;
                });
              },
              child: const Text(
                'Reset',
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: statuses.length,
                itemBuilder: (context, index) => ElevatedButton(
                  onPressed: index > curIndex
                      ? () {
                          setState(() {
                            lastIndex = curIndex;
                            curIndex = index;
                          });
                        }
                      : null,
                  child: Text(
                    '$index',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
