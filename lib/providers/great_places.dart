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
    PlaceLocation pickedLocation,
  ) async {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: pickedLocation,
    );

    _items.add(newPlace);
    (await HiveHelper.getDB<Place>("user_place"))
        .put(newPlace.id.toString(), newPlace);
    notifyListeners();
  }

  Future<void> fetchAndSetData() async {
    var db = await HiveHelper.getDB<Place>("user_place");
    _items = db.values.toList();
  }

  Future<Place?> getPlace(String id) async {
    return (await HiveHelper.getDB<Place>("user_place")).get(id);
  }

  Future<void> deletePlace(String id) async {
    (await HiveHelper.getDB<Place>("user_place")).delete(id);
  }
}
