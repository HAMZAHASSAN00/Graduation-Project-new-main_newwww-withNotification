import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/newFeature/profileUI/widgets/profile_list_item.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../Screens/Welcome/welcome_screen.dart';
import '../../model/UserModel.dart';
import '../../network/local/cache_helper.dart';


// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Builder(
//         builder: (context) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             home: ProfileScreen(),
//           );
//         },
//       ),
//     );
//   }
// }

class ProfileScreen extends StatelessWidget {

  UserModel? cachedUserData = CacheHelper.getUserData(key: 'user_data');
  @override
  Widget build(BuildContext context) {

    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          // AppBar(backgroundColor:Colors.blue),
          Container(
            height:  100,
            width:  100,
            margin: EdgeInsets.only(top: 30),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Color(0xFFFFFFFF),
                  radius: 50,
                  child: ClipOval(
                    child: Lottie.network(
                      "https://lottie.host/dab72ada-5a3c-4e75-bdce-54e9168de214/SS7K24yqSc.json",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // CircleAvatar(
                //   radius: 50,
                //   backgroundImage: Lottie.network(
                //     "https://lottie.host/dab72ada-5a3c-4e75-bdce-54e9168de214/SS7K24yqSc.json",
                //     fit: BoxFit.cover,
                //   ),
                // ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      heightFactor: 15,
                      widthFactor: 15,
                      child: Icon(
                        LineAwesomeIcons.pen,
                        color: Colors.grey,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            cachedUserData?.name ?? '',
            style: TextStyle(
              fontSize:30,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5),
          Text(
            cachedUserData?.email ?? '',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        profileInfo,
      ],
    );

    return Container(
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Color(0xFFBAD3FF),
            body: Column(
              children: <Widget>[
                header,
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      ProfileListItem(
                        icon: LineAwesomeIcons.user_shield,
                        text: 'Privacy',
                        onTap: () {
                          // Handle the press event here
                          print('Profile item pressed!');
                        },
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.history,
                        text: 'Purchase History',
                        onTap: () {
                          // Handle the press event here
                          print('Profile item pressed!');
                        },
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.question_circle,
                        text: 'Help & Support',
                        onTap: () {
                          // Handle the press event here
                          print('Profile item pressed!');
                        },
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.cog,
                        text: 'Settings',
                        onTap: () {
                          // Handle the press event here
                          print('Profile item pressed!');
                        },
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.user_plus,
                        text: 'Invite a Friend',
                        onTap: () {
                          // Handle the press event here
                          print('Profile item pressed!');
                        },
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.alternate_sign_out,
                        text: 'Logout',
                        hasNavigation: false,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("logout"),
                                content: Text("Are you sure you want to logout?"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      FirebaseAuth.instance.signOut();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WelcomeScreen(),
                                        ),
                                      );
                                    },
                                    child: Text("logout"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Close"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}