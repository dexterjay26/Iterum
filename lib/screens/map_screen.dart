import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import '../providers/google_sign_in.dart';

class MapScreen extends StatefulWidget {
  // Map<String, double> locData = UserHelper().getCurrentLocation();

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> controller1;
  static LatLng _initialPosition;
  Set<Marker> _markers = {};
  //static LatLng _lastMapPosition = _initialPosition;

  void getCurrentLocation() async {
    final locData = await Location().getLocation();
    setState(() {
      _initialPosition = LatLng(locData.latitude, locData.longitude);
    });
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      controller1.complete(controller);
    });
  }

  // _onAddMarkerButtonPressed() {
  //   setState(() {
  //     _markers.add(Marker(
  //         markerId: MarkerId(_lastMapPosition.toString()),
  //         position: _lastMapPosition,
  //         infoWindow: InfoWindow(
  //             title: "Pizza Parlour",
  //             snippet: "This is a snippet",
  //             onTap: () {}),
  //         onTap: () {},
  //         icon: BitmapDescriptor.defaultMarker));
  //   });
  // }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void showRespondDialog(String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Respond!!!"),
        content: Container(
          width: 300,
          child: Text('HI'),
        ),
        actions: [
          FlatButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
            },
            child: Text('Close'),
          ),
          FlatButton(
            onPressed: () async {
              await Provider.of<GoogleSignInProvider>(context, listen: false)
                  .respondHelp(id);
              Navigator.of(ctx).pop();
            },
            child: Text('Respond'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context);

    try {
      if (provider.markerSnapshot.docs.isNotEmpty) {
        print('not empty');
        provider.markerSnapshot.docs.forEach((e) {
          _markers.add(
            Marker(
              markerId: MarkerId(e.data()['id']),
              position: LatLng(e.data()['lat'], e.data()['lng']),
              onTap: () => showRespondDialog(e.data()['id']),
            ),
          );
        });
      } else {
        print('wala laman');
      }
    } catch (e) {
      print('dito ung error');
      print(e.toString());
    }

    return _initialPosition == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 14.4746,
            ),
            mapType: MapType.normal,
            buildingsEnabled: false,
            myLocationEnabled: true,
            compassEnabled: true,
            // onTap: widget.isSelecting ? _selectLocation : null,
            markers: _markers,
          );
  }
}
