import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

const double tankWidth = 150.0;
const double tankHeight = 150.0;
class TankWidget extends StatelessWidget {
  final String title;
  final String cm;
  final double tankLevel;

  const TankWidget({
    required this.title,
    required this.cm,
    required this.tankLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: tankWidth,
      height: tankHeight,
      child: Stack(
        children: [
          Lottie.network('https://lottie.host/df8e353c-bd78-4e8f-b334-4f909e7fe105/9uCcG2UZP7.json'),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  "$cm %",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.black45.withOpacity(0.4)),
                ),
                SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.black45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
