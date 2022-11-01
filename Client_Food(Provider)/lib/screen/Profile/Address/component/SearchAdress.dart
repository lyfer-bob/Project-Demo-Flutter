import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_webservice/places.dart' as google_maps_api;
import 'package:provider/provider.dart';
import '../AddressSavePageProvider.dart';

class SearchAdress extends StatefulWidget {
  //use for don't dispose
  // location bts siam
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  _SearchAdress createState() => _SearchAdress();
}

class _SearchAdress extends State<SearchAdress> {
  PickResult? selectedPlace;
  PlacePicker? testPlacePicker;

  bool checkLoading = true;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        checkLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlacePicker(
        apiKey: 'key google',
        hintText: "Find a place ...",
        searchingText: "Please wait ...",
        selectText: "Select place",
        outsideOfPickAreaText: "Place not in area",
        initialPosition: SearchAdress.kInitialPosition,
        autoCompleteDebounceInMilliseconds: 1000,
        autocompleteOffset: 5,
        forceAndroidLocationManager: true,
        useCurrentLocation: true,
        selectInitialPosition: true,
        usePinPointingSearch: true,
        usePlaceDetailSearch: true,
        autocompleteLanguage: "TH",
        autocompleteComponents: [google_maps_api.Component("country", "th")],
        region: 'TH',
        onAutoCompleteFailed: (String error) {
          print('not success $error');
        },
        introModalWidgetBuilder: (context, close) {
          return Visibility(
            visible: checkLoading,
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Material(
                  child: Material(
                    type: MaterialType.canvas,
                    color: Theme.of(context).cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 4.0,
                    child: Center(
                      child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: CircularProgressIndicator()),
                    ),
                  ),
                )),
          );
        },
        onPlacePicked: (PickResult result) {
          // setState(() {
          //   selectedPlace = result;
          //   testPlacePicker = null;
          //   Navigator.of(context).pop();
          // });
          debugPrint('get lat lng');
          debugPrint('${result.geometry!.location.lat}');
          debugPrint('${result.geometry!.location.lng}');
          Provider.of<AddressSavePageProvider>(context, listen: false)
              .changeAddressSelect(
                  context,
                  result.formattedAddress.toString(),
                  result.geometry!.location.lat.toString(),
                  result.geometry!.location.lng.toString());
        });
  }
}
