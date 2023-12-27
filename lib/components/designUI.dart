
import 'package:flutter/material.dart';
AppBar customAppBar(BuildContext context,title) {
  return AppBar(
    backgroundColor: Color(0xFFBAD3FF),
    elevation: 0,
    title: Text(
      title,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.notifications),
        onPressed: () {
          // Handle notifications button press
        },
      ),
      IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          Navigator.of(context).pushNamed('SettingsPage');
        },
      ),
    ],
  );
}

Color perfictBlue=Color(0xFFBAD3FF);
AlertDialog dialog=   AlertDialog(
  title: Text("Logout"),
  content: Text("Are you sure you want to logout?"),
  actions: <Widget>[
    TextButton(
      onPressed: () {

      },
      child: Text("Logout"),
    ),
    TextButton(
      onPressed: () {
      },
      child: Text("Close"),
    ),
  ],
);


AlertDialog customAlertDialog({
  String? action1,
  String? action2,
  Function()? onPressedAction1,
  Function()? onPressedAction2,
  dynamic icon,
  Color? iconColor,
  String? title,
  String? content,
  TextStyle? contentTextStyle,
  List<Widget>? actions,
  MainAxisAlignment actionsAlignment = MainAxisAlignment.center,
  OverflowBarAlignment? actionsOverflowAlignment,
  Color? backgroundColor,
  double? elevation,
  Color? shadowColor,
  Color? surfaceTintColor,
  String? semanticLabel,
}) {
  return AlertDialog(
    title: title != null
        ? Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    )
        : null,
    content: content != null
        ? Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        content,
        style: contentTextStyle ?? TextStyle(fontSize: 16.0),
      ),
    )
        : null,
    actions: actions ?? <Widget>[
      TextButton(
        onPressed: onPressedAction1,
        child: Text(
          action1 ?? '',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.redAccent, // Adjust color as needed
          ),
        ),
      ),
      TextButton(
        onPressed: onPressedAction2,
        child: Text(
          action2 ?? '',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.blueAccent, // Adjust color as needed
          ),
        ),
      ),
    ],
    actionsAlignment: actionsAlignment,
    actionsOverflowAlignment: actionsOverflowAlignment,
    backgroundColor: backgroundColor ?? Colors.white,
    elevation: elevation,
    shadowColor: shadowColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    contentPadding: const EdgeInsets.all(16.0),
  );
}



