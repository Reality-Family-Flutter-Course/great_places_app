import 'package:flutter/material.dart';
import 'package:great_places_app/core/location_helper.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageURL;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();

    if (locData.latitude == null || locData.longitude == null) return;
    String staticImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: locData.latitude!,
      longitude: locData.longitude!,
    );

    setState(() {
      _previewImageURL = staticImageUrl;
    });
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
          child: _previewImageURL == null
              ? const Text(
                  "Местоположение не выбрано",
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageURL!,
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
                onPressed: () {},
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
