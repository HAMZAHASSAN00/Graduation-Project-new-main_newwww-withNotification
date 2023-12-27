import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../../repo/user_repositry.dart';
import 'data/tank_shape.dart';
import 'data/textData.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  late Future<Stream<Map<String, dynamic>>> futureDataStream;
  UserRepository userRepository = UserRepository();
  bool isAutomaticMode = false;

  @override
  void initState() {
    super.initState();
    // Get the data stream when the widget is initialized
    futureDataStream = userRepository.getDataStream();
  }

  @override
  Widget build(BuildContext context) {
    print('form dataPage : ${OneSignal.User.pushSubscription.id}');
    return FutureBuilder(
      future: futureDataStream,
      builder: (context, AsyncSnapshot<Stream<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          Stream<Map<String, dynamic>> dataStream = snapshot.data!;

          return StreamBuilder(
            stream: dataStream,
            builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                Map<String, dynamic> userData = snapshot.data!;
                // CacheHelper.saveData(key: 'allUserData', value: userData);

                return Scaffold(
                  body: Container(
                    color: Color(0xFFBAD3FF),
                    child: Stack(
                      children: [
                        //BackgroundImage(),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      ImportantDataWidget(userData: userData),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: TankWidget(
                                          title: "Roof Tank",
                                          cm: userData['cmRoof'],
                                          tankLevel: 0.4,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        child: TankWidget(
                                          title: "Ground Tank",
                                          cm: userData['cmGround'],
                                          tankLevel: 0.7,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}
