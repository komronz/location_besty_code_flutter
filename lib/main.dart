import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test_great_places/providers/great_places.dart';
import 'package:test_great_places/screens/place_list_screen.dart';
import './screens/add_place_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
      MyApp(),
  );
}

//TODO provider
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GreatPlaces(),
      child: MainApp(),
    );
  }
}

//TODO bloc provider
// class MyApp1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (bloc_context) => PlaceCubit(),
//       child: MainApp(),
//     );
//   }
// }



class MainApp extends StatelessWidget {
 // const MainAPp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Location Besty',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          shadowColor: Colors.black,
          elevation: 6,
          backgroundColor: Colors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 18),
        )
      ),
      home: PlacesListScreen(),
      routes: {
        AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
        //PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
      },
    );
  }
}
