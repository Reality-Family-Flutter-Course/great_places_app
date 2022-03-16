import 'package:hive/hive.dart';

class HiveHelper {
  static Future<Box<T>> getDB<T>(String boxName) async {
    return await Hive.openBox<T>(boxName);
  }

  static void closeDB() {
    Hive.close();
  }
}
