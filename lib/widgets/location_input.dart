import 'package:flutter/material.dart';
import 'package:great_places_app/core/location_helper.dart';
import 'package:great_places_app/models/place.dart';
import 'package:great_places_app/screens/map_screen.dart';
import 'package:location/location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class LocationInput extends StatefulWidget {
  final Function(PlaceLocation) callBack;

  const LocationInput({
    required this.callBack,
    Key? key,
  }) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _placeLocation;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();

    if (locData.latitude == null || locData.longitude == null) return;
    _getPlaceLocation(
      locData.latitude!,
      locData.longitude!,
    );
  }

  Future<void> _getPlaceLocation(
    double latitude,
    double longitude,
  ) async {
    String address = await LocationHelper.getAddressFromGeoPoint(
      latitude: latitude,
      longitude: longitude,
    );

    PlaceLocation placeLocation = PlaceLocation(
      id: "p1",
      latitude: latitude,
      longitude: longitude,
      address: address,
    );

    setState(() {
      _placeLocation = placeLocation;
    });

    widget.callBack(_placeLocation!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _placeLocation == null
              ? const Text(
                  "Местоположение не выбрано",
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  LocationHelper.generateLocationPreviewImage(
                    latitude: _placeLocation!.latitude,
                    longitude: _placeLocation!.longitude,
                  ),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          children: [
            Expanded(
              child: TextButton.icon(
                onPressed: _getCurrentUserLocation,
                icon: const Icon(Icons.location_on),
                label: const Text(
                  "Нынешнее местоположение",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: TextButton.icon(
                onPressed: () async {
                  var selectedPoint = await Navigator.push<Point>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(),
                    ),
                  );

                  if (selectedPoint == null) return;
                  _getPlaceLocation(
                    selectedPoint.latitude,
                    selectedPoint.longitude,
                  );
                },
                icon: const Icon(Icons.map),
                label: const Text(
                  "Выбрать на карте",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
