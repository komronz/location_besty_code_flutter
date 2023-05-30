import 'package:flutter/material.dart';


class FullImage extends StatelessWidget {
  static final routeName = 'full-image';
  final FileImage image;
  final String title;
  final Function showInMap;
  FullImage(this.image, this.title, this.showInMap);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x94360000),
      appBar: AppBar(
        backgroundColor: Color(0x45000000),
        title: Text(title, style: TextStyle(color: Colors.white),),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Color(0xFFA80000),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton.small(
              onPressed: showInMap,
              backgroundColor: Color(0xFFA80000),
              child: Center(child: Icon(Icons.location_on_rounded, color: Colors.white,),),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 100),
        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
          child: Image(
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            image: image,
          ),
        ),
      ),
    );
  }
}
