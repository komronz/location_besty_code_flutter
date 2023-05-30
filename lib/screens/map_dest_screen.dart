import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapDestScreen extends StatefulWidget {
  final double longitude;
  final double latitude;

  MapDestScreen({this.longitude, this.latitude});


  @override
  State<MapDestScreen> createState() => _MapDestScreenState();
}

class _MapDestScreenState extends State<MapDestScreen> {


  GoogleMapController _googleMapController;
  Marker _origin;
  Marker _destination;

  void _addMarker(LatLng pos){
    if(_origin == null || (_origin != null && _destination != null)){
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos
        );
        _destination = null;
      });

    }else{
      setState(() {
        _destination = Marker(
            markerId: const MarkerId('destination'),
            infoWindow: const InfoWindow(title: 'Destination'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: pos
        );
      });
    }
  }


  @override
  void dispose() {
    super.dispose();
    _googleMapController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("test Place"),
      ),
      body: GoogleMap(
        mapToolbarEnabled: true,
        zoomControlsEnabled: false,
        compassEnabled: true,
        zoomGesturesEnabled: true,
        mapType: MapType.hybrid,
        onMapCreated: (controller) => _googleMapController = controller,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.latitude,
            widget.longitude,
          ),
          zoom: 16,
        ),
        onLongPress: _addMarker,
        markers: {
          if(_origin != null) _origin,
          if(_destination != null) _destination,
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
                  widget.latitude,
                  widget.longitude,
                ),
                zoom: 16,
              ),
            )
        ),
      ),
    );
  }
}
