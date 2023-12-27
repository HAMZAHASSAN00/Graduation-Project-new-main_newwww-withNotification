import 'package:flutter/material.dart';
import 'package:flutter_auth/newFeature/profileUI/ProfileScreen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../Screens/System/components/NavBar.dart';
import '../Screens/System/components/data.dart';
import '../Screens/System/components/solarCells.dart';
import '../Screens/System/components/tank.dart';


class GoogleBottomBar extends StatefulWidget {
  const GoogleBottomBar({Key? key}) : super(key: key);

  @override
  State<GoogleBottomBar> createState() => _GoogleBottomBarState();
}

class _GoogleBottomBarState extends State<GoogleBottomBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFBAD3FF),
        elevation: 0,
        title: Text(
          "Automatic Pump",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications button press
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Handle settings button press
            },
          ),
        ],
      ),
      drawer: NavBar(),
      body: Center(
        child: _widgitItems[_selectedIndex],
      ),
      bottomNavigationBar: SalomonBottomBar(


          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff6200ee),
          unselectedItemColor: const Color(0xff757575),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: _navBarItems),
    );
  }
}
final _widgitItems = [const DataPage(), const TankPage(), const SolarCellsPage(),ProfileScreen(),];
final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title: const Text("Home"),
    selectedColor: Colors.teal,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.water_drop_rounded),
    title: const Text("Tank"),
    selectedColor: Colors.blueAccent,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.sunny),
    title: const Text("Solar Cells"),
    selectedColor: Colors.orange,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person),
    title: const Text("Profile"),
    selectedColor: Colors.indigo,
  ),
];
