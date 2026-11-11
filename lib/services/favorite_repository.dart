import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:latres_mobile_124240042/models/tv_show.dart';

class FavoriteRepository {
  static const _boxName = 'favorites';

  static Box<dynamic> get _box => Hive.box(_boxName);

  static ValueListenable<Box<dynamic>> get listenable => _box.listenable();

  static bool contains(int showId) => _box.containsKey(showId.toString());

  static Future<void> add(TvShow show) {
    return _box.put(show.id.toString(), show.toJson());
  }

  static Future<void> remove(int showId) {
    return _box.delete(showId.toString());
  }

  static List<TvShow> getAll() {
    return _box.values.map((value) {
      if (value is! Map) {
        throw const FormatException('Data favorit tidak valid.');
      }
      return TvShow.fromJson(Map<String, dynamic>.from(value));
    }).toList();
  }
}
