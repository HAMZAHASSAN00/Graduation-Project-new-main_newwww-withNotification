import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tank Selector',
      home: TankSelectorScreen(),
    );
  }
}

class TankSelectorScreen extends StatefulWidget {
  @override
  _TankSelectorScreenState createState() => _TankSelectorScreenState();
}

class _TankSelectorScreenState extends State<TankSelectorScreen> {
  int selectedTankIndex = -1;

  final List<String> tankNames = ['Tank 10L', 'Tank 20L', 'Tank 50L'];
  final List<String> tankImages = [
    'assets/images/water.png', // replace with your image paths
    'assets/images/water.png',
    'assets/images/water.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tank Selector'),
      ),
      body: ListView.builder(
        itemCount: tankNames.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTankIndex = index;
              });
            },
            child: Card(
              color: selectedTankIndex == index ? Colors.blue : null,
              child: ListTile(
                leading: Image.asset(
                  tankImages[index],
                  width: 50,
                  height: 50,
                ),
                title: Text(tankNames[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
