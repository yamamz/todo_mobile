import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_mobile/ultils/theme_util.dart';
import 'package:todo_mobile/views/pages/my_home_page.dart';

import 'constants/color_constant.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator(Environment.prod);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoSansTextTheme(),
        primarySwatch: ThemeUtils.createMaterialColorFromShade500(primaryColor),
        cursorColor: primaryColor,
        textSelectionHandleColor: primaryColor,
        toggleableActiveColor: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}
