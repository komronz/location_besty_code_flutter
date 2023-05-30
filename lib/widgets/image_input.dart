import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  var color = Colors.grey;

  ImageInput(this.onSelectImage, this.color);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  XFile _storedImage;

  Future<void> _takePicture() async {
    print('!!!!!!!!!!!!!!!!!!! TEST ON CAMERA  (STARTING BLOC)');
    // final image = await ImagePicker().pickImage(
    //   source: ImageSource.camera,
    //   maxWidth: 600,
    // );
    final ImagePicker _picker = ImagePicker();
    //pick file from gallery, it will return XFile
    final XFile image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );

    if (image == null) {
      return;
    }
   // print('!!!!!!!!!!!!!!!!!!! TEST ON CAMERA  ( AFTER if() )');
    setState(() {
      _storedImage = image;
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final savedImage = await File(image.path).copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
    //print('!!!!!!!!!!!!!!!!!!! TEST ON CAMERA  ( ending )');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 170,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.green),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
            //_storedImage,
            File(_storedImage.path),
            fit: BoxFit.cover,
            alignment: Alignment.center,
            width: double.infinity,
          )
              :  Text(
            'No Image Taken',
            style: TextStyle(
              color: widget.color,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 0.5)
          ),
          width: double.infinity,
          child: TextButton.icon(
            icon: const Icon(Icons.camera,),
            label:  Text('Take Picture', ),
            //textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}