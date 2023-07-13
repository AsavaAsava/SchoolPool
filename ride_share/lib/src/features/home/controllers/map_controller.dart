import 'package:flutter/cupertino.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';

import '../../../../auth/secrets.dart';

class MapController extends GetxController{
  Future<Prediction?> showGoogleAutoComplete(BuildContext context) async {
    Prediction? p = await PlacesAutocomplete.show(
      offset: 0,
      radius: 1000,
      strictbounds: false,
      region: "ke",
      language: "en",
      context: context,
      mode: Mode.overlay,
      apiKey: mapsAPIKey,
      components: [Component(Component.country, "ke")],
      types: [],
      hint: "Search City",
    );

    return p;
  }
}