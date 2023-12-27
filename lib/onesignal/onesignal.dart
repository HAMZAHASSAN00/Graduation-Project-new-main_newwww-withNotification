import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalClass {

  Future<void> initPlatform() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  }
}