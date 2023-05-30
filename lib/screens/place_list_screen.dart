import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:test_great_places/screens/wating_data.dart';
import '../models/place.dart';
import 'package:provider/provider.dart';
import 'package:test_great_places/screens/full_image.dart';
import 'package:test_great_places/screens/map_dest_screen.dart';
import '../providers/great_places.dart';
import '../screens/add_place_screen.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'map_screen.dart';

class PlacesListScreen extends StatefulWidget {


  @override
  State<PlacesListScreen> createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  bool _waiting = false;

   _deleteMethod({
    BuildContext context,
    int i,
    GreatPlaces greatPlaces,
  }) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          title: Text(
            'Warning',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).errorColor),
          ),
          content: const Text(
            'Are you sure to delete this place?',
            style:
                TextStyle(fontWeight: FontWeight.w400, color: Colors.black87),
          ),
          actions: [
            TextButton(
              child: const Text('NO'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('YES'),
              onPressed: ()  async {
                await Provider.of<GreatPlaces>(context, listen: false).deleteById(greatPlaces.items[i].id.toString());
                Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces();
                Navigator.of(context).pop();
                // await BlocProvider.of<PlaceCubit>(context, listen: false).deleteById(
                //     context.read<PlaceCubit>().items[i].id.toString());
                // BlocProvider.of<PlaceCubit>(context, listen: false).fetchAndSetPlaces();
                //Navigator.of(context).pop();
                print('here');
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteItem({BuildContext context, GreatPlaces greatPlaces, int i}) async{
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 5,
            title: Text(
              'Warning',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).errorColor),
            ),
            content: const Text(
              'Are you sure to delete this place?',
              style:
              TextStyle(fontWeight: FontWeight.w400, color: Colors.black87),
            ),
            actions: [
              TextButton(
                child: const Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('YES'),
                onPressed: ()  async {
                  await Provider.of<GreatPlaces>(context, listen: false).deleteById(greatPlaces.items[i].id.toString());
                  Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces();
                  Navigator.of(context).pop();
                  print('here');
                },
              ),
            ],
          );
        }
    );
   }
  Future<void> _enteringMap() async {
    setState(() {
      _waiting = true;
    });
    final locData = await Location().getLocation();
    final selectedLocation = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MapDestScreen(
            latitude: locData.latitude,
            longitude: locData.longitude,
          ),
        )
    );
    if (selectedLocation == null) {
      setState(() {
        _waiting = true;
      });
    }
    setState(() {
      _waiting= false;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Location Besty'),
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
            ConnectionState.waiting
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Consumer<GreatPlaces>(
          child: const Center(
            child: Text('Got no places yet start adding some!'),
          ),
          builder: (ctx, greatPlaces, ch) =>
          greatPlaces.items.isEmpty
              ? ch
              : ListView.builder(
            itemCount: greatPlaces.items.length,
            itemBuilder: (ctx, i) {
              String str = greatPlaces.items[i].location.address;
              int index = str.indexOf(',');
              String address = str.substring(index + 1);
              return ContainerList(
                deleteItem: () => _deleteItem(context: context, i: i, greatPlaces: greatPlaces),
                title: greatPlaces.items[i].title,
                address: address,
                imageFile: FileImage(
                  greatPlaces.items[i].image,
                ),
                deleteFunction: null,
                showInMap:  () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (ctx) => MapScreen(
                        initialLocation: greatPlaces.items[i].location,
                      ),
                    ),
                  );
                },
                waiting: _waiting,
                showImage: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                        builder: (context) => FullImage(
                          FileImage(greatPlaces.items[i].image,),
                          greatPlaces.items[i].title,
                              () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (ctx) => MapScreen(
                                  initialLocation: greatPlaces.items[i].location,
                                ),
                              ),
                            );
                          },
                        ),
                    ),
                  );
                },
                getDest: _enteringMap,
              );
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.large(
        elevation: 20,
        onPressed: _waiting ? null : () => Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
        child: _waiting ? CircularProgressIndicator(color: Colors.white,) : Icon(Icons.add_rounded, color: Colors.white, size:70,),
        backgroundColor: const Color(0xFF0B0088),
      ),
    );
  }
}
class ContainerList extends StatelessWidget {
  final String title;
  final String address;
  final bool waiting;
  final FileImage imageFile;
  final deleteFunction;
  final Function showInMap;
  final Function showImage;
  final Function deleteItem;
  final Function getDest;

  ContainerList({
    @required this.title,
    @required this.address,
    @required this.imageFile,
    @required this.deleteFunction,
    @required this.showInMap,
    @required this.showImage,
    @required this.deleteItem,
    @required this.getDest,
    this.waiting = false,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom: 14, top: 14, left: 10, right: 10),
      width: 390,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: const Color(0xFFA1A1A1),
            width: 1.0,
            style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500],
            offset: const Offset(
              5.0,
              5.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
      ), //BoxShadow
      BoxShadow(
        color: Colors.grey[500],
        offset: const Offset(1.0, 1.0),
        blurRadius: 5.0,
        spreadRadius: 2.0,
      ),
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 10,
            ),
            width: 140,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                  offset: Offset(2,5),
                  spreadRadius: 1,
                )
              ]
            ),
            child: Stack(
              children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: DropShadowImage(
                  scale: 1,
                  offset: const Offset(5,5),
                  blurRadius: 10,
                  borderRadius: 10,
                  image: Image(
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                    alignment: Alignment.center,
                    image: imageFile,
                  ),
                ),
              ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: InkWell(
                    onTap: showImage,
                    child: Container(
                      alignment: Alignment.center,
                      height: 26,
                      width: 26,
                      decoration: BoxDecoration(
                          color: Color(0x91031B2A),
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Icon(Icons.fullscreen,color: Colors.white,),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: InkWell(
                    onTap: deleteItem,
                    child: Container(
                      alignment: Alignment.center,
                      height: 26,
                      width: 26,
                      decoration: BoxDecoration(
                          color: Color(0x91031B2A),
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Icon(Icons.delete_outline,color: Colors.white,),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(title.toString(),
                    style: TextStyle(fontSize: 18, color: const Color(0xFF0B0088), fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 6,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("LOCATION: ",
                        style: TextStyle(
                            fontSize: 10,
                            color: const Color(0xFF003D98), fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                          child: Text(address.toString(),
                            style: TextStyle(fontSize: 10, color: const Color(
                                0xFF5A5A5A), fontWeight: FontWeight.w500),
                          ),
                      ),
                    ]
                ),
                SizedBox(height: 10,),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      iconSize: MaterialStateProperty.all(20),
                      iconColor: MaterialStateProperty.all(Color(0xFF003D98)),
                      fixedSize: MaterialStatePropertyAll(Size.fromHeight(30)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(color: Colors.grey),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Color(
                          0x45CD7CFF)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: showInMap,
                    icon: Icon(Icons.map_rounded),
                    label: Text("show in map",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                      ),),
                  ),
                ),
                SizedBox(height: 2,),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      iconSize: MaterialStateProperty.all(50),
                      iconColor: MaterialStateProperty.all(Color(0xFF003D98)),
                      fixedSize: MaterialStatePropertyAll(Size.fromHeight(60)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.grey),
                          ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Color(0x45CD7CFF)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: getDest,
                    icon: Icon(Icons.location_on_rounded),
                    label: Text("Let's Go",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
