import 'dart:io';
import 'package:flutter/material.dart';
import 'package:test_great_places/models/place.dart';
import '../providers/great_places.dart';
import '../widgets/image_input.dart';
import 'package:provider/provider.dart';
import '../widgets/location_input.dart';


class AddPlaceScreen extends StatefulWidget {
  //const AddPlaceScreen({Key? key}) : super(key: key);
  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  bool _checkImage = true;
  bool _checkLocation = true;
  File _pickedImage;
  PlaceLocation _pickedLocation;


  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;
  }
  void _selectPlace(double lat, double lng){
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }



  bool _checkFilled(){
    if ( _pickedImage == null ||  _pickedLocation == null) return false;
    else return true;
  }

  ///provider
  void _savePlace1(BuildContext context) async {

    if(_pickedLocation == null) {
      setState(() {
        _checkLocation = false;
      });
    }
    if(_pickedImage == null) {
      setState(() {
        _checkImage = false;
      });
    }
    if(_formKey.currentState.validate() && _checkFilled()){
      await Provider.of<GreatPlaces>(context, listen: false)
          .addPlace(_titleController.text, _pickedImage, _pickedLocation);
      Navigator.of(context).pop();
    }
    return;
    print('!!!!!!!!!! AFTER IF');

  }
  ///bloc provider
  // void _savePlace1(BuildContext context1){
  //
  //   if(_titleController.text.isEmpty || _pickedImage == null || _pickedLocation == null){
  //     print('!!!!!! IN IF');
  //
  //     return;
  //   }
  //   print('!!!!!!!!!! AFTER IF');
  //   context1.read<PlaceCubit>().addPlace(_titleController.text, _pickedImage, _pickedLocation);
  //   print('Results');
  //   print(_titleController.text);
  //   print(_pickedImage.toString());
  //   print(_pickedLocation.toString());
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text('Add a New Place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        maxLength: 26,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(label: Text('Title')),
                        controller: _titleController,
                      ),
                      const SizedBox(height: 10,),
                      ImageInput(_selectImage, _checkImage ? Colors.grey : Colors.red),
                      const SizedBox(height: 10,),
                      LocationInput(_selectPlace, _checkLocation ? Colors.grey : Colors.red),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => _savePlace1(context),
            label: const Text('Add Place'),
            icon: const Icon(Icons.add),
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                elevation: MaterialStatePropertyAll(0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap

            ),
          ),
        ],
      ),
    );
  }
}
