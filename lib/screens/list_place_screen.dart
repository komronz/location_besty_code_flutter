// import 'package:drop_shadow_image/drop_shadow_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
// import 'package:test_great_places/bloc_cubit/place_cubit.dart';
// import 'package:test_great_places/providers/great_places.dart';
// import 'package:test_great_places/screens/add_place_screen.dart';
//
// import 'map_screen.dart';
//
//
// class PlaceListScreen extends StatelessWidget {
//
//   Future<void> _deleteMethod({
//     BuildContext context,
//     int i,
//   }) async {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           elevation: 5,
//           title: Text(
//             'Warning',
//             style: TextStyle(
//                 fontWeight: FontWeight.w400,
//                 color: Theme.of(context).errorColor),
//           ),
//           content: const Text(
//             'Are you sure to delete this place?',
//             style:
//             TextStyle(fontWeight: FontWeight.w400, color: Colors.black87),
//           ),
//           actions: [
//             TextButton(
//               child: const Text('NO'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text('YES'),
//               onPressed: ()  async {
//                 // Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces();
//                 // await Provider.of<GreatPlaces>(context, listen: false).deleteById(greatPlaces.items[i].id.toString());
//                 // Navigator.of(context).pop();
//                 context.read<PlaceCubit>().deleteById(context.read<PlaceCubit>().items[i].id.toString());
//                 print(context.read<PlaceCubit>().items);
//                 await context.read<PlaceCubit>().items.removeWhere((element) {
//                   print(element.id.toString());
//                   print(context.read<PlaceCubit>().items[i].id.toString());
//                   return element.id.toString() == context.read<PlaceCubit>().items[i].id.toString();
//                 });
//                 Navigator.of(context).pop();
//                 print('here');
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => GreatPlaces(),
//     child: Scaffold(
//       backgroundColor: Colors.greenAccent,
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Your Places Test'),
//         backgroundColor: Colors.green,
//         actions: [
//           IconButton(
//               onPressed: () => Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
//               icon: const Icon(Icons.add),
//           )
//         ],
//       ),
//       body: BlocBuilder<PlaceCubit, PlaceState>(
//         builder: (context, state) {
//           final placeCubit = context.read<PlaceCubit>();
//           return placeCubit.items.isEmpty
//               ? const Center(child: Text('You have not any data yet! Start adding your best locations!'),)
//               : ListView.builder(
//               itemBuilder: (context, i) {
//                 final placeCubitBuilder = context.read<PlaceCubit>();
//                 return Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.all(20),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.green,
//                           borderRadius: const BorderRadius.all(
//                               Radius.circular(10)),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               spreadRadius: 4,
//                               blurRadius: 5,
//                               offset: const Offset(
//                                   0, 3), // changes position of shadow
//                             ),
//                           ],
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment:
//                             CrossAxisAlignment.center,
//                             children: [
//                               ClipRRect(
//                                 borderRadius:
//                                 BorderRadius.circular(5),
//                                 child: DropShadowImage(
//                                   scale: 1,
//                                   offset: const Offset(5, 5),
//                                   blurRadius: 10,
//                                   borderRadius: 20,
//                                   image: Image(
//                                     fit: BoxFit.cover,
//                                     height: 220,
//                                     width: double.infinity,
//                                     alignment: Alignment.center,
//                                     image: FileImage(
//                                       placeCubitBuilder.items[i]
//                                           .image,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               //todo.................................................................
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Center(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           'TITLE ${i}',
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontWeight:
//                                               FontWeight.w200,
//                                               fontSize: 12),
//                                           textAlign: TextAlign.center,
//                                         ),
//                                         SizedBox(
//                                           width: 250,
//                                           child: Center(
//                                               child: Text(placeCubitBuilder.items[i].title,
//                                                   style: const TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight: FontWeight.w500,
//                                                       fontSize: 14))),
//                                         ),
//                                         const Text(
//                                           'LOCATION',
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontWeight:
//                                               FontWeight.w200,
//                                               fontSize: 12),
//                                         ),
//                                         SizedBox(
//                                           width: 250,
//                                           child: Center(
//                                             child: Text(placeCubitBuilder.items[i].location.address,
//                                               // .substring(9,greatPlaces.items[i].location.address.length),
//                                               style: const TextStyle(
//                                                   color: Colors.white,
//                                                   fontWeight:
//                                                   FontWeight.w500,
//                                                   fontSize: 14),
//                                               textAlign:
//                                               TextAlign.center,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius:
//                                       BorderRadius.circular(5),
//                                     ),
//                                     child: Container(
//                                       height: 50,
//                                       width: 50,
//                                       decoration: BoxDecoration(
//                                         borderRadius:
//                                         BorderRadius.circular(10),
//                                         color: Colors.green,
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.white
//                                                 .withOpacity(0.4),
//                                             spreadRadius: 4,
//                                             blurRadius: 5,
//                                             offset: const Offset(1,
//                                                 1), // changes position of shadow
//                                           ),
//                                         ],
//                                       ),
//                                       child: Center(
//                                         child: IconButton(
//                                           icon: const Icon(
//                                             Icons.place_outlined,
//                                             size: 30,
//                                             color: Colors.white,
//                                           ),
//                                           onPressed: () {
//                                             Navigator.of(context)
//                                                 .push(
//                                               MaterialPageRoute(
//                                                 fullscreenDialog:
//                                                 true,
//                                                 builder: (ctx) =>
//                                                     MapScreen(
//                                                       initialLocation: ctx
//                                                           .read<
//                                                           PlaceCubit>()
//                                                           .items[i]
//                                                           .location,
//                                                     ),
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       top: 10,
//                       right: 10,
//                       child: Container(
//                         height: 50,
//                         width: 50,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.white.withOpacity(0.5),
//                               spreadRadius: 3,
//                               blurRadius: 5,
//                               offset: const Offset(
//                                   1, 1), // changes position of shadow
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: IconButton(
//                             icon: const Icon(
//                               Icons.delete_outline,
//                               size: 30,
//                               color: Colors.red,
//                             ),
//                             onPressed: () async {
//                               Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces();
//                               await Provider.of<GreatPlaces>(context, listen: false).deleteById(placeCubit.items[i].id.toString());
//                               print("test");
//                               // await _deleteMethod(context: context, i: i);
//                               // print("${placeCubit.items} nothing");
//                             },
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 );
//               },
//             itemCount: placeCubit.items.length,
//           );
//         },
//       ),
//     ),
// );
//   }
// }
