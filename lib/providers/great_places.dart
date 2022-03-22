import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places_app/core/hive_helper.dart';
import 'package:great_places_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(
    String pickedTitle,
    File pickedImage,
  ) async {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: null,
    );

    _items.add(newPlace);
    (await HiveHelper.getDB<Place>("user_place")).add(newPlace);
    notifyListeners();
  }

  Future<void> fetchAndSetData() async {
    var db = await HiveHelper.getDB<Place>("user_place");
    _items = db.values.toList();
  }
}
