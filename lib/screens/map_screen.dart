import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../models/place.dart';



class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;
  final locData = Location().getLocation();

  // Future<LatLng> get _getCurrentUserLocation async {
  //     final locData = await Location().getLocation();
  //     return LatLng(locData.latitude, locData.latitude);
  // }

  // void builderContext(BuildContext context, LatLng lat, LatLng lng){
  //   this.initialLocation.latitude = lat;
  //   initialLocation.longitude = lng;
  // }

  MapScreen({
    this.initialLocation =
    const PlaceLocation(latitude: 40.0, longitude: 71.6683482),
    this.isSelecting = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position){
    setState(() {
      _pickedLocation = position;
    });
  }
  GoogleMapController _googleMapController;


  @override
  void dispose() {
    super.dispose();
    _googleMapController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Map'),
        actions: [
          if(widget.isSelecting)
            IconButton(
                onPressed: _pickedLocation == null ? null : () {
                  Navigator.of(context).pop(_pickedLocation);
                },
                icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: GoogleMap(
        mapToolbarEnabled: true,
        zoomControlsEnabled: false,
        compassEnabled: true,
        zoomGesturesEnabled: true,
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        onMapCreated: (controller) => _googleMapController = controller,
        markers: (_pickedLocation == null && widget.isSelecting) ? {} : {
          Marker(markerId: const MarkerId('m1'),
            position: _pickedLocation
                ??
                LatLng(
                    widget.initialLocation.latitude,
                    widget.initialLocation.longitude,
                ),
          ),
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        child: Icon(Icons.center_focus_strong_rounded),
        onPressed: () => _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                widget.initialLocation.latitude,
                widget.initialLocation.longitude,
              ),
              zoom: 16,
            ),
          )
        ),
      ),
    );
  }
}