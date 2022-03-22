import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  final String id;

  const PlaceDetailScreen({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).getPlace(id);

    return FutureBuilder(
      future: selectedPlace,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            return Container();
          } else {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text("К сожалению, место не найдено"),
              ),
            );
          }
        }
      },
    );
  }
}
