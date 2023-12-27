import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/newFeature/profileUI/ProfileScreen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../Screens/System/components/NavBar.dart';
import '../Screens/System/components/data.dart';
import '../Screens/System/components/solarCells.dart';
import '../Screens/System/components/tank.dart';


class CurvedNavPage extends StatefulWidget {
  const CurvedNavPage({Key? key}) : super(key: key);

  @override
  State<CurvedNavPage> createState() => _CurvedNavPageState();
}

class _CurvedNavPageState extends State<CurvedNavPage> {
  Color colorth=Colors.black;

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
           // color: colorth,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
           // color: colorth,
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications button press
            },
          ),
          IconButton(
           // color: colorth,
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
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor:  Color(0xFFBAD3FF),
          animationDuration: Duration(milliseconds: 400),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: _navBarItemsCurv),
    );
  }
}
final _navBarItemsCurv=[  Icon(Icons.home),Icon(Icons.water_drop_rounded),Icon(Icons.sunny)];
final _widgitItems = [const DataPage(), const TankPage(), const SolarCellsPage(),ProfileScreen(),];
