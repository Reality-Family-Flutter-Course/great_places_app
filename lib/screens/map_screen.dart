import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late YandexMapController _controller;
  final List<MapObject> _mapObject = [];

  final MapObjectId userPlacemarkId = MapObjectId('userPoint');
  final MapObjectId selectedPlacemarkId = MapObjectId('selectedPoint');

  Point? _selectedPoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ваша карта"),
        actions: [
          IconButton(
            onPressed: (_mapObject.any((placemark) =>
                        placemark.mapId == selectedPlacemarkId) &&
                    _selectedPoint != null)
                ? () {
                    Navigator.pop(
                      context,
                      _selectedPoint,
                    );
                  }
                : null,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          YandexMap(
            mapObjects: _mapObject,
            onMapCreated: (controller) async {
              _controller = controller;
            },
            onMapTap: (point) {
              setState(() {
                _selectedPoint = point;
                _mapObject.add(
                  Placemark(
                    mapId: selectedPlacemarkId,
                    point: point,
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
              });
            },
          ),
          Container(
            padding: const EdgeInsets.only(
              bottom: 60,
            ),
            child: RawMaterialButton(
              fillColor: Colors.white,
              elevation: 2,
              onPressed: () async {
                if (!(await Permission.location.request().isGranted)) {
                  print("Permission is not granted");
                }

                print(await _controller.getUserCameraPosition());

                LocationData locData = await Location().getLocation();

                _controller.moveCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: Point(
                        latitude: locData.latitude ?? 0,
                        longitude: locData.longitude ?? 0,
                      ),
                      zoom: 13,
                    ),
                  ),
                  animation: MapAnimation(),
                );
              },
              child: const Icon(Icons.place),
              padding: const EdgeInsets.all(10.0),
              shape: const CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
