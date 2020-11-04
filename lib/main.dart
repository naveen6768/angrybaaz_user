import 'package:angrybaaz_user/screens/customScreen.dart';
import 'package:angrybaaz_user/screens/homeOverviewScreen.dart';
import 'package:angrybaaz_user/screens/itemOverviewScreen.dart';
import 'package:angrybaaz_user/screens/visitStoreItemTypeScreen.dart';
import 'package:angrybaaz_user/widgets/specificTypeCategory.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/customScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        accentColor: Color(0xff382933),
        primaryColor: Color(0xff671B97),
        scaffoldBackgroundColor: Colors.white,
        cursorColor: Color(0xff671B97),
      ),
      initialRoute: HomeOverviewScreen.id,
      routes: {
        HomeOverviewScreen.id: (context) => HomeOverviewScreen(),
        ItemOverviewScreen.id: (context) => ItemOverviewScreen(),
        SpecificTypeCategory.id: (context) => SpecificTypeCategory(),
        VisitStoreItemType.id: (context) => VisitStoreItemType(),
        // CustomScreen.id: (context) => CustomScreen(),
        // MyHomePage.id: (context) => MyHomePage(),
      },
    );
  }
}
