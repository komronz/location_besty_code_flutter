import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../helpers/location_helper.dart';
import '../models/place.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  var color = Colors.grey;

  LocationInput(this.onSelectPlace, this.color);


  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  bool _isloading = false;
  bool _isloadingMap = false;

  void _showPreview(double lat, double lng){

    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    print(staticMapImageUrl);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }


  Future<void> _getCurrentUserLocation() async {
    try{
      setState(() {
        _isloading = true;
      });
      final locData = await Location().getLocation();
      _showPreview(
        locData.latitude,
        locData.longitude,
      );
      widget.onSelectPlace(
        locData.latitude,
        locData.longitude,
      );
    }catch(err){
      return;
    }
    setState(() {
      _isloading = false;
    });
  }

  Future<void> _selectOnMap() async {
    setState(() {
      _isloadingMap = true;
    });
    final locData = await Location().getLocation();
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
          initialLocation: PlaceLocation(
              latitude: locData.latitude,
              longitude: locData.longitude,
          ),
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPreview(
        selectedLocation.latitude,
        selectedLocation.longitude,
    );
    widget.onSelectPlace(
        selectedLocation.latitude,
        selectedLocation.longitude,
    );
    setState(() {
      _isloadingMap = false;
    });

    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.green),
          ),
          child: _previewImageUrl == null
              ? Text(
            'No Location Chosen',
            style: TextStyle(
              color: widget.color,
            ),
            textAlign: TextAlign.center,
          )
              : Image.network(
            _previewImageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton.icon(
              icon: const Icon(
                Icons.location_on,
              ),
              label: _isloading ? const Text('loading...') : const Text('Current Location'),
              style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor)
              ),
              onPressed: _getCurrentUserLocation,
            ),
            TextButton.icon(
              icon: const Icon(
                Icons.map,
              ),
              label: _isloadingMap ? const Text('loading...') : const Text('Select on Map'),
              style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor)
              ),
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}