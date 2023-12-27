import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/local/cache_helper.dart';

class NotificationPage extends StatefulWidget {
  final List<String> notifications;

  NotificationPage({required this.notifications});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late List<bool> readStatus;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _initializeReadStatus();
    _configureOneSignal();
  }

  // ...
  void _configureOneSignal() {
    //    OneSignal.Notifications.addClickListener((event) {
    //      String message = event.notification.body ?? "";
    //   setState(() {
    //     widget.notifications.insert(0, message); // Add to the beginning of the list
    //     readStatus.insert(0, false); // Set initial read status to false
    //     _saveReadStatus();
    //   });
    //
    // });

      OneSignal.Notifications.addForegroundWillDisplayListener((event) {
        String message = event.notification.body ?? "";
        setState(() {
          widget.notifications.insert(0, message); // Add to the beginning of the list
          readStatus.insert(0, false); // Set initial read status to false
          _saveReadStatus();
        });
        // _showNotificationDialog(context, message);
        print("body is indedededed notifi: ${event.notification.body}");
      });
  }

  // void _configureOneSignal() {
  //   OneSignal.Notifications.addClickListener(
  //           (event) {
  //         print("all events: $event");
  //         print("body is: ${event.notification.body}");
  //       });
  //   OneSignal.Notifications.addForegroundWillDisplayListener((event) {
  //     String message = event.notification.body ?? "";
  //     _showNotificationDialog(context, message);
  //     print("body is indedededed: ${event.notification.body}");
  //   });
  // }

  _initializeReadStatus() async {
    prefs = await SharedPreferences.getInstance();

    // Initialize the read status list from SharedPreferences
    readStatus = List.generate(widget.notifications.length, (index) {
      return prefs.getBool('readStatus_$index') ?? false;
    });

    setState(() {
      List<String> allNotifications = CacheHelper.getAllNotifications();
      for (String notification in allNotifications) {
        widget.notifications.insert(0, notification); // Add to the beginning of the list
        readStatus.insert(0, false); // Set initial read status to false
        _saveReadStatus();
        print('Notification: $notification');
      }
    });
  }

  _saveReadStatus() {
    // Save the read status list to SharedPreferences
    for (int i = 0; i < widget.notifications.length; i++) {
      prefs.setBool('readStatus_$i', readStatus[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (readStatus == null) {
      // Handle the case where readStatus is not initialized yet
      return CircularProgressIndicator();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.notifications,
                size: 50.0,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                'Recent Notifications',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: widget.notifications.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(widget.notifications[index]),
                    onDismissed: (direction) {
                      setState(() {
                        widget.notifications.removeAt(index);
                        readStatus.removeAt(index);
                        _saveReadStatus();
                      });
                    },
                    background: Container(
                      color: Colors.redAccent,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 16.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _showNotificationDialog(
                            context, widget.notifications[index]);
                        setState(() {
                          // Mark the notification as read when tapped
                          readStatus[index] = true;
                          _saveReadStatus();
                        });
                      },
                      child: Card(
                        elevation: 2.0,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        color:Colors.white,
                        child: ListTile(
                          title: Text(
                            widget.notifications[index],
                            style: TextStyle(fontSize: 18.0),
                          ),
                          leading: Icon(
                            Icons.notifications_active,
                            color: readStatus[index]
                                ? Colors.grey
                                : Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotificationDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notification'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
