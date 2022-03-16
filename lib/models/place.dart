import 'dart:io';

import 'package:hive/hive.dart';

// for building adapters use - flutter packages pub run build_runner build

@HiveType(typeId: 1)
class PlaceLocation {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final double latitude;
  @HiveField(2)
  final double longitude;
  @HiveField(3)
  final String? address;

  PlaceLocation({
    required this.id,
    required this.latitude,
    required this.longitude,
    this.address,
  });
}

@HiveType(typeId: 0)
class Place {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final PlaceLocation? location;
  @HiveField(3)
  final File image;

  Place({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });
}
