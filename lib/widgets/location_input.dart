import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageURL;

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
                onPressed: () {},
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
