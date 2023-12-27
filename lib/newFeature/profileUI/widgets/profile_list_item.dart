import 'package:flutter/material.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  final VoidCallback? onTap;

  const ProfileListItem({
    Key? key,
    required this.icon,
    required this.text,
    this.hasNavigation = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        margin: EdgeInsets.symmetric(
          horizontal: 40,
        ).copyWith(
          bottom: 20,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Row(
          children: <Widget>[
            Icon(this.icon),
            SizedBox(width: 10),
            Text(
              this.text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,)
            ),
          ],
        ),
      ),
    );
  }
}
