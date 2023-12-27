
// class NavBar extends StatelessWidget {
//   const NavBar({Key? key}) : super(key: key);
//
//
//   void _showDialog(BuildContext context, String title, String content) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(content),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("Close"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final user=FirebaseAuth.instance.currentUser!;
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           UserAccountsDrawerHeader(
//             accountName: Text("Hamza"),
//             accountEmail: Text(user.uid!,),
//             currentAccountPicture: CircleAvatar(
//               child: ClipOval(
//                 child: Image.asset(
//                   "assets/images/waterBackground.jpg",
//                   width: 90,
//                   height: 90,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             decoration: BoxDecoration(
//               color: Colors.blue,
//               image: DecorationImage(
//                   fit: BoxFit.fill,
//                   image: NetworkImage(
//                       'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
//             ),
//           ),
//           ListTile(
//             leading: Icon(Icons.info),
//             title: Text('How the System Works'),
//             onTap: () {
//               Navigator.pop(context); // Close the drawer
//               _showDialog(context, 'How the System Works',
//                   'Description of how the system works.');
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.settings),
//             title: Text('Settings'),
//             onTap: () {
//               Navigator.pop(context); // Close the drawer
//               // Implement "Settings" action here
//               // Navigate to the settings page or show a settings dialog
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.people),
//             title: Text('About Us'),
//             onTap: () {
//               Navigator.pop(context); // Close the drawer
//               _showDialog(context, 'About Us',
//                   'Description of your team or organization.');
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.notifications),
//             title: Text('notifications'),
//             onTap: () {
//
//             },
//             trailing: ClipOval(
//               child: Container(
//                 color: Colors.red,
//                 width: 20,
//                 height: 20,
//                 child: Center(
//                   child: Text(
//                     '8',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           ListTile(
//             leading: Icon(Icons.exit_to_app),
//             title: Text('logout'),
//             onTap: () {
//               Navigator.pop(context);
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: Text("logout"),
//                     content: Text("Are you sure you want to logout?"),
//                     actions: <Widget>[
//                       TextButton(
//                         onPressed: () {
//                           //close the showDialog
//                           Navigator.of(context).pop();
//                           //logout form firebase
//                           FirebaseAuth.instance.signOut();
//                           //logout form system
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => WelcomeScreen(),
//                             ),
//                           );
//                         },
//                         child: Text("logout"),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: Text("Close"),
//                       ),
//                     ],
//                   );
//                   ;
//                 },
//               );// Close the drawer
//             },
//
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/designUI.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../model/UserModel.dart';
import '../../../network/local/cache_helper.dart';
import '../../Welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../repo/user_repositry.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shadowColor:Color(0xFFFFFFFF),
      child: FutureBuilder<Map<String, dynamic>>(
        future: UserRepository().getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            Map<String, dynamic> userData = snapshot.data!;
            UserModel userModel = UserModel(
              name: userData['name'],
              email: userData['email'],
            );
            CacheHelper.saveUserData(key: 'user_data', userData: userModel);

            return ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(userData['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 25),),
                  accountEmail: Text(userData['email'],style: TextStyle(color: Colors.black),),
                  currentAccountPicture: Hero(
                    tag: 'userImage',
                    child: CircleAvatar(
                      backgroundColor: Color(0xFFFFFFFF),
                      child: ClipOval(
                        child: Lottie.network(
                          "https://lottie.host/dab72ada-5a3c-4e75-bdce-54e9168de214/SS7K24yqSc.json",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFD9E4FA),
                    // image: DecorationImage(
                    //   fit: BoxFit.fill,
                    //   image: NetworkImage(
                    //     'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg',
                    //   ),
                    // ),
                  ),
                ),
                ListTile(
                  leading: Icon(LineAwesomeIcons.person_entering_booth),
                  title: Text('Profile'),
                  onTap: () {
                    Navigator.of(context).pushNamed('ProfileScreen');
                    // Add your logic for "How the System Works"
                  },
                ),
                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('notifications'),
                  onTap: () {
                    Navigator.of(context).pushNamed('NotificationPage');
                  },
                  trailing: ClipOval(
                    child: Container(
                      color: Colors.red,
                      width: 20,
                      height: 20,
                      child: Center(
                        child: Text(
                          '8',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.dark_mode),
                  title: Text('theme'),
                  onTap: () {
                    Navigator.of(context).pushNamed('ThemePage');
                    // Add your logic for "How the System Works"
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.of(context).pushNamed('SettingsPage');

                  },
                ),
                ListTile(
                  leading: Icon(Icons.line_style_rounded),
                  title: Text('New style'),
                  onTap: () {
                    Navigator.of(context).pushNamed('GoogleBottomBar');
                    // Add your logic for "Settings"
                  },
                ),
                ListTile(
                  leading: Icon(Icons.line_style_rounded),
                  title: Text('New style 2'),
                  onTap: () {
                    Navigator.of(context).pushNamed('system');
                    // Add your logic for "Settings"
                  },
                ),

                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('How the System Works'),
                  onTap: () {
                    Navigator.of(context).pushNamed('HowItWorksPage');
                    // Add your logic for "How the System Works"
                  },
                ),

                ListTile(
                  leading: Icon(Icons.people),
                  title: Text('About Us'),
                  onTap: () {
                    Navigator.of(context).pushNamed('AboutUsPage');
                    // Add your logic for "About Us"
                  },
                ),

                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                  onTap: () {
                    Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return customAlertDialog(
                              action1: 'Logout',
                              action2: 'Close',
                              onPressedAction1: () {
                                Navigator.of(context).pop();
                                FirebaseAuth.instance.signOut();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WelcomeScreen(),
                                  ),
                                );
                              },
                              onPressedAction2: () {
                                Navigator.of(context).pop();
                              },
                              title: 'Logout',
                              content: 'Are you sure you want to logout?',
                              contentTextStyle: TextStyle(fontSize: 16.0),
                              backgroundColor: perfictBlue,
                            );
                          },
                        );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}