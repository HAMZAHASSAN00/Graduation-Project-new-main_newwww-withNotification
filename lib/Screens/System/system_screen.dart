import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/System/components/NavBar.dart';
import '../../components/designUI.dart';
import 'components/data.dart';
import 'components/solarCells.dart';
import 'components/tank.dart';

class SystemScreen extends StatefulWidget {
  const SystemScreen({Key? key,}) : super(key: key);

  @override
  _SystemScreenState createState() => _SystemScreenState();
}

class _SystemScreenState extends State<SystemScreen> {
  late PageController _pageController;
  int _page = 0;
  double groundTankLevel = 0.7; // Sample value, replace with actual data
  double roofTankLevel = 0.4; // Sample value, replace with actual data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context,"Automatic Pump"),
      drawer: NavBar(),
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: onPageChanged,
        children: <Widget>[
          const DataPage(),
          const TankPage(),
          const SolarCellsPage(),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        elevation: 8.0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.data_thresholding_outlined),
            label: "Data",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop_rounded),
            label: "Tank",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sunny),
            label: "solar cells",
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }

  Widget buildTank(String title, double tankLevel) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blue,
              ),
            ),
            Container(
              width: 150 * tankLevel,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.lightBlue,
              ),
            ),
            Positioned.fill(
              child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${(tankLevel * 100).toInt()}% ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${title} ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
        // SizedBox(height: 20),
        // Text(
        //   title,
        //   style: TextStyle(fontSize: 24),
        //),
      ],
    );
  }

  void navigationTapped(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

}

// void main() {
//   runApp(const MaterialApp(
//     home: BottomNavigation(title: 'Bottom Navigation Demo'),
//   ));
// }
