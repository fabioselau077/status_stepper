# status_stepper

Use this package for showing status changing. For now available only left to right animation.

![](https://github.com/Progressive-Mobile/status_stepper/blob/0ed01e34803e66da47a8aabc68a0ee6367e3cc53/readme_resources/status_stepper.gif)

## Quick reference

Property | What does it do
-------- | ---------------
animationDuration    | The duration of animation for 1 stepper item, multiplyes by 2(for animating connector and item) * n(n - count of children to animate)
animationDelayDuration    | Duration before starting animation 
currentIndex    | Current status index, -1 if there are no  active items
lastActiveIndex    | Animation starts after widget at this position 
activeColor    | Color of active and passed statuses, by default is Theme.of(context).primaryColor 
disabledColor    | Color of next statuses, by default is Theme.of(context).colorScheme.secondaryContainer 
connectorCurve    | Curve for the connectors
itemCurve    | Curve for the status widgets
connectorThickness    | Thickness of the connector 

## Example

```dart
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
```