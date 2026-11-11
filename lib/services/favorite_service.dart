import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flicksy/models/tv_show.dart';

class FavoriteService {
  static const _boxName = 'favorites';

  FavoriteService({Box<dynamic>? box}) : _box = box ?? Hive.box(_boxName);

  final Box<dynamic> _box;

  ValueListenable<Box<dynamic>> get listenable => _box.listenable();

  bool isFavorite(int showId) => _box.containsKey(showId.toString());

  Future<void> addFavorite(TvShow show) {
    return _box.put(show.id.toString(), show.toJson());
  }

  Future<void> removeFavorite(int showId) {
    return _box.delete(showId.toString());
  }

  List<TvShow> getFavorites() {
    return _box.values.map((value) {
      if (value is! Map) {
        throw const FormatException('Data favorit tidak valid.');
      }
      return TvShow.fromJson(Map<String, dynamic>.from(value));
    }).toList();
  }
}
