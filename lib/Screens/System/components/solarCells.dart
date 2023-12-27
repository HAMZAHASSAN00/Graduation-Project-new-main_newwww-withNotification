import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../network/local/cache_helper.dart';
import '../../../repo/user_repositry.dart';

class SolarCellsPage extends StatefulWidget {
  const SolarCellsPage({Key? key}) : super(key: key);

  @override
  _SolarCellsPageState createState() => _SolarCellsPageState();
}

class _SolarCellsPageState extends State<SolarCellsPage> {
  late Future<Stream<Map<String, dynamic>>> futureDataStream;
  UserRepository userRepository = UserRepository();
  bool isTurnedOnSolar = false;
  late bool isAutomaticMode;
  late GlobalKey<_SolarCellsPageState> pageKeySolar;

  @override
  void initState() {
    super.initState();
    pageKeySolar = GlobalKey<_SolarCellsPageState>();
    isAutomaticMode = CacheHelper.getBoolean(key: 'isAutomaticMode') ?? false;
    // Retrieve the value of isTurnedOn from CacheHelper
    isTurnedOnSolar = CacheHelper.getBoolean(key: 'isTurnedOnSolar') ?? false;
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
                return Container(
                  color: Color(0xFFBAD3FF),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isTurnedOnSolar)
                          Lottie.network(
                            'https://lottie.host/5064be26-9728-468f-a3ae-6d78ad7db05f/R0Or7FxaP5.json',
                            width: 100,
                            height: 100,
                          ),
                        if (!isTurnedOnSolar)
                          Lottie.network(
                            'https://lottie.host/6bea2814-2d68-4ec6-befa-14883ef430df/JpTR9TEEZd.json',
                          ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Transform.scale(
                                scale: 1.5,
                                child: Switch(
                                  value: userData['isTurnedOnSolar'],
                                  onChanged: isAutomaticMode
                                      ? null
                                      : (value) {
                                    setState(() {
                                      isTurnedOnSolar = value;
                                      userData['isTurnedOnSolar'] =
                                          value;
                                      print(userData['uID']);
                                    });
                                    userRepository.updateFirestoreData(
                                        'isTurnedOnSolar',
                                        value,
                                        'Users',
                                        userData['email']);
                                    CacheHelper.putBoolean(
                                        key: 'isTurnedOnSolar',
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
                          isTurnedOnSolar
                              ? 'Electrical heater is ON'
                              : 'You are using The Solar Cells ',
                          style: TextStyle(
                            fontSize: 20,
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
