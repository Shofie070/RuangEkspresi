import 'package:shared_preferences/shared_preferences.dart';

/// ✅ Simpan list string ke SharedPreferences
Future<void> saveList(String key, List<String> values) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList(key, values);
}

/// ✅ Ambil list string dari SharedPreferences
Future<List<String>> loadList(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList(key) ?? [];
}
