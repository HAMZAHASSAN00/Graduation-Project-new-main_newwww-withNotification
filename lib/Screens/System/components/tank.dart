import 'package:flutter/material.dart';
import 'package:flutter_auth/network/local/cache_helper.dart';
import 'package:lottie/lottie.dart';

import '../../../repo/user_repositry.dart';

class TankPage extends StatefulWidget {
  const TankPage({Key? key}) : super(key: key);

  @override
  _TankPageState createState() => _TankPageState();
}

class _TankPageState extends State<TankPage> {
  late Future<Stream<Map<String, dynamic>>> futureDataStream;
  UserRepository userRepository = UserRepository();
  bool isTurnedOnTank = false;
  bool isAutomaticMode = false;
  late GlobalKey<_TankPageState> pageKeyTank;

  @override
  void initState() {
    super.initState();
    pageKeyTank = GlobalKey<_TankPageState>();
    isAutomaticMode = CacheHelper.getBoolean(key: 'isAutomaticMode') ?? false;
    isTurnedOnTank = CacheHelper.getBoolean(key: 'isTurnedOnTank') ?? false;
    futureDataStream = userRepository.getDataStream();
  }

  @override
  Widget build(BuildContext context) {
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
                bool userDataIsTurnedOnTank=userData['isTurnedOnTank'];
                return Container(
                  color: Color(0xFFBAD3FF),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isTurnedOnTank ? 'The pump is ON' : 'The pump is OFF',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                          ),
                        ),
                        Lottie.network(
                          'https://lottie.host/8cf67add-e2ae-46fd-8e70-1bd984c95b2a/Wga2XhFXsq.json',
                          animate: isTurnedOnTank,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Transform.scale(
                                scale: 1.5,
                                child: Switch(
                                  value: isTurnedOnTank,
                                  onChanged: isAutomaticMode
                                      ? (userDataIsTurnedOnTank){
                                    setState(() {
                                      isTurnedOnTank = userDataIsTurnedOnTank;
                                      print(userDataIsTurnedOnTank.toString());
                                    });
                                  }
                                      : (value) {
                                    setState(() {
                                      isTurnedOnTank = value;
                                      print(userDataIsTurnedOnTank.toString());
                                    });
                                    userRepository.updateFirestoreData(
                                        'isTurnedOnTank',
                                        value,
                                        'Users',
                                        userData['email']);
                                    CacheHelper.putBoolean(
                                        key: 'isTurnedOnTank',
                                        value: value);
                                  },
                                  inactiveThumbColor: Colors.black45,
                                  activeColor: Colors.white,
                                  activeTrackColor: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          isTurnedOnTank
                              ? 'Will send you a notification when the tank is filled'
                              : '----',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          isAutomaticMode
                              ? 'Automatic mode must be turned off to be able to control'
                              : '',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
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
