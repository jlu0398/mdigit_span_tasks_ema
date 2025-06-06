import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAndroidBuildVersion extends Fake implements AndroidBuildVersion {
  @override
  String get release => 'testAndroidOSVersion';
}

class MockAndroidDevice extends Fake implements AndroidDeviceInfo {
  @override
  String get model => 'testAndroidModel';

  @override
  AndroidBuildVersion get version => MockAndroidBuildVersion();
}

class MockIosDevice extends Fake implements IosDeviceInfo {
  @override
  String get model => 'testIosModel';

  @override
  get systemVersion => 'testIosOsVersion';
}

class MockDeviceInfoPlugin extends Fake implements DeviceInfoPlugin {
  final AndroidDeviceInfo androidDeviceInfo;
  final IosDeviceInfo iosDeviceInfo;

  MockDeviceInfoPlugin({
    required this.androidDeviceInfo,
    required this.iosDeviceInfo,
  });

  @override
  Future<AndroidDeviceInfo> get androidInfo async {
    return androidDeviceInfo;
  }

  @override
  Future<IosDeviceInfo> get iosInfo async {
    return iosDeviceInfo;
  }
}
