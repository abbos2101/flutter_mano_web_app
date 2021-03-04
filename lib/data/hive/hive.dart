import 'package:hive/hive.dart';

enum HiveKeys {
  token,
  hasChanges,
  hasUser,
}

class HiveDB {
  final String key = 'tune';
  Box _box;

  Future<Box> _getBox() async {
    if (_box != null) return _box;
    Hive.init("data");
    _box = await Hive.openBox("$key");
    return _box;
  }

  Future<void> saveToken(String data) async =>
      (await _getBox()).put("${HiveKeys.token}", data);

  Future<String> getToken() async =>
      (await _getBox()).get("${HiveKeys.token}") ?? '';

  Future<void> saveHasChanges(bool data) async =>
      (await _getBox()).put("${HiveKeys.hasChanges}", data);

  Future<bool> getHasChanges() async =>
      (await _getBox()).get("${HiveKeys.hasChanges}") ?? true;

  Future<void> saveHasUser(bool data) async =>
      (await _getBox()).put("${HiveKeys.hasUser}", data);

  Future<bool> getHasUser() async =>
      (await _getBox()).get("${HiveKeys.hasUser}") ?? false;

  void close() => _box.close();

  void clear() => _box.clear();
}
