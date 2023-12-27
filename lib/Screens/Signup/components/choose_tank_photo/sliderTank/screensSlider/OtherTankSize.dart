import 'package:flutter/material.dart';

import '../../../../../../network/local/cache_helper.dart';
import '../models.dart';


class OtherTankSize extends StatefulWidget {
  @override
  _OtherTankSizeState createState() => _OtherTankSizeState();
}

class _OtherTankSizeState extends State<OtherTankSize> {
  TextEditingController widthController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  String result = '';
  String _selectedTank = 'Cylindrical Water Tank';



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('tank data'.toUpperCase()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButtonFormField<String>(
              value: _selectedTank,
              onChanged: (value) {
                setState(() {
                  _selectedTank = value!;
                });
              },
              items: ['Rectangular Water Tank', 'Cylindrical Water Tank',].map((tank) {
                return DropdownMenuItem<String>(
                  value: tank,
                  child: Text(tank),
                );
              }).toList(),
              decoration: InputDecoration(
                hintText: "Select your tank",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.propane_tank),
                ),
              ),
            ),

            SizedBox(height: 16.0),

            TextField(
              controller: widthController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Width'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Height'),
            ),
            SizedBox(height: 16.0),

            Visibility(
              visible: _selectedTank == 'Rectangular Water Tank',
              child: TextField(
                controller: lengthController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Length'),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Retrieve values from controllers
                double width = double.tryParse(widthController.text) ?? 0.0;
                double height = double.tryParse(heightController.text) ?? 0.0;
                double length = double.tryParse(lengthController.text) ?? 0.0;

                // Create TankModel instance
                TankModel tankModel = TankModel(tankName: _selectedTank, height: height,width: width,length: length);
                CacheHelper.saveTankModel(key: 'TankModel', tankModel: tankModel);
                  Navigator.of(context).pushNamed('signupScreen');

                // Do something with the tankModel, for example, print the values
                print('Tank Name: ${tankModel.tankName}');
                print('Width: ${tankModel.width}');
                print('Height: ${tankModel.height}');
              },
              child: Text('select'),
            ),

          ],
        ),
      ),
    );
  }


}
