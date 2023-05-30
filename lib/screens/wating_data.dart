//FutureBuilder(
//         future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces(),
//         //Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces(),
//         builder: (context, snapshot) => snapshot.connectionState ==
//                 ConnectionState.waiting
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : Consumer<GreatPlaces>(
//           child: const Center(
//             child: Text('Got no places yet start adding some!'),
//           ),
//           builder: (ctx, greatPlaces, ch) =>
//           greatPlaces.items.isEmpty
//               ? ch
//               : ListView.builder(
//             itemCount: greatPlaces.items.length,
//             itemBuilder: (ctx, i) {
//               return Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.all(20),
//                     child: Container(
//                       decoration:  BoxDecoration(
//                         // gradient: const LinearGradient(
//                         //   end: Alignment.centerLeft,
//                         //   begin: Alignment.centerRight,
//                         //   colors: [Colors.blue, Colors.green],
//                         // ),
//                         color: Colors.green,
//                         borderRadius: const BorderRadius.all(Radius.circular(10)),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: 4,
//                             blurRadius:5,
//                             offset: const Offset(0, 3), // changes position of shadow
//                           ),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(5),
//                               child: DropShadowImage(
//                                 scale: 1,
//                                 offset: const Offset(5,5),
//                                 blurRadius: 10,
//                                 borderRadius: 20,
//                                 image: Image(
//                                     fit: BoxFit.cover,
//                                     height: 220,
//                                     width: double.infinity,
//                                     alignment: Alignment.center,
//                                     image: FileImage(
//                                       greatPlaces.items[i].image,
//                                     ),
//                                   ),
//                               ),
//                               ),
//                             //todo.................................................................
//                             const SizedBox(height: 10,),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Center(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       const Text('TITLE',
//                                         style:  TextStyle(color: Colors.white, fontWeight: FontWeight.w200, fontSize: 12),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                          SizedBox(width: 250, child: Center(child: Text(greatPlaces.items[i].title,style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14))),),
//                                      const Text('LOCATION',
//                                        style:  TextStyle(color: Colors.white, fontWeight: FontWeight.w200, fontSize: 12 ),
//                                      ),
//                                      SizedBox(
//                                        width: 250,
//                                        child: Center(
//                                          child: Text(greatPlaces.items[i].location
//                                              .address,
//                                             // .substring(9,greatPlaces.items[i].location.address.length),
//                                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14), textAlign: TextAlign.center,),
//                                        ),
//                                      ),
//                                       ],
//                                     ),
//                                 ),
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     child: Container(
//                                       height: 50,
//                                       width: 50,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: Colors.green,
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.white.withOpacity(0.4),
//                                             spreadRadius: 4,
//                                             blurRadius: 5,
//                                             offset: const Offset(1, 1), // changes position of shadow
//                                           ),
//                                         ],
//                                       ),
//                                       child: Center(
//                                         child:  IconButton(
//                                           icon: const Icon(Icons.place_outlined, size: 30, color: Colors.white,
//                                           ),
//                                           onPressed: () {
//                                             Navigator.of(context).push(
//                                               MaterialPageRoute(
//                                                 fullscreenDialog: true,
//                                                 builder: (ctx) => MapScreen(
//                                                   initialLocation: greatPlaces.items[i].location,
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 10,
//                     right: 10,
//                     child: Container(
//                       height: 50,
//                       width: 50,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.white.withOpacity(0.5),
//                             spreadRadius: 3,
//                             blurRadius: 5,
//                             offset: const Offset(1, 1), // changes position of shadow
//                           ),
//                         ],
//                       ),
//                       child: Center(
//                         child: IconButton(
//                          icon: const Icon(Icons.delete_outline,size: 30, color: Colors.red,),
//                          onPressed: () async => _deleteMethod(context: context, i: i, greatPlaces: greatPlaces),
//                      ),
//                       ),
//                     ),
//                   )
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//
