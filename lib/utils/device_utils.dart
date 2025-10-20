import 'package:device_info_plus/device_info_plus.dart';

Future<Map<String, String>> getDeviceInfo() async {
  final deviceInfo = DeviceInfoPlugin();
  final androidInfo = await deviceInfo.androidInfo;
  return {
    "model": androidInfo.model,
    "version": androidInfo.version.release,
  };
}
