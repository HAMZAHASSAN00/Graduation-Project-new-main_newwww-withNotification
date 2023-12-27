import 'package:flutter/material.dart';
import 'package:flutter_auth/model/UserModel.dart';
import 'package:flutter_auth/network/local/cache_helper.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../components/designUI.dart';
import '../../../../repo/user_repositry.dart';

class ImportantDataWidget extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ImportantDataWidget({required this.userData});

  @override
  State<ImportantDataWidget> createState() => _ImportantDataWidgetState();
}

class _ImportantDataWidgetState extends State<ImportantDataWidget> {
  bool isAutomaticMode = false;
  UserRepository userRepository = UserRepository();
  @override
  void initState() {
    super.initState();

    // Retrieve the saved value of isAutomaticMode when the widget is created
    isAutomaticMode = CacheHelper.getBoolean(key: 'isAutomaticMode') ?? false;
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(20.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Important Data",
            style: TextStyle(fontSize: 24, color: Colors.blueAccent, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Roof tank contain : ${widget.userData['cmRoof']} % \n Ground tank contain :  ${widget.userData['cmGround']} %',
            style: TextStyle(fontSize: 18, color: Colors.blueAccent),
            textAlign: TextAlign.center,
          ),
          UserRepository().getImportantDataText(widget.userData),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Toggle automatic mode
              setState(() {
                isAutomaticMode = !isAutomaticMode;
                // Save the updated value of isAutomaticMode
                CacheHelper.saveBoolean(key: 'isAutomaticMode', value: isAutomaticMode);
                widget.userData['isAutomaticMode'] = isAutomaticMode;
              });
              userRepository.updateFirestoreData(
                  'isAutomaticMode',
                  isAutomaticMode,
                  'Users',
                  widget.userData['email']);

            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isAutomaticMode ? Colors.green : Colors.grey,
              disabledBackgroundColor: Colors.grey,
              textStyle: TextStyle(color: perfictBlue), // Text color
              padding: EdgeInsets.all(16), // Button padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isAutomaticMode ? 'Automatic Mode' : 'Automatic Mode is Off',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Icon(
                  isAutomaticMode ? Icons.power : Icons.power_settings_new,
                  size: 20, // Adjust the size of the icon as needed
                ),
              ],
            ),
          ),

          SizedBox(height: 10),
          Text(
            isAutomaticMode ? 'Automatic mode is active' : '',
            style: TextStyle(
              fontSize: 16,
              color: isAutomaticMode ? Colors.green : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),



        ],
      ),
    );
  }
}
