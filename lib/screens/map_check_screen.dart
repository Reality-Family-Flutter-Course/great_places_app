import 'package:flutter/material.dart';
import 'package:great_places_app/models/place.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapCheckScreen extends StatelessWidget {
  final PlaceLocation location;
  final List<MapObject> _mapObjects = [];

  MapCheckScreen({required this.location, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _mapObjects.add(
      Placemark(
        mapId: const MapObjectId("place"),
        point: Point(
          latitude: location.latitude,
          longitude: location.longitude,
        ),
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(
              'assets/images/choosed_place.png',
            ),
            rotationType: RotationType.rotate,
          ),
        ),
        opacity: 1,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Посмотреть на карте"),
      ),
      body: YandexMap(
        mapObjects: _mapObjects,
        onMapCreated: (controller) {
          controller.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: Point(
                  latitude: location.latitude,
                  longitude: location.longitude,
                ),
              ),
            ),
            animation: MapAnimation(),
          );
        },
      ),
    );
  }
}
