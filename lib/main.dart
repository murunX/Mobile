import 'package:BieDaalt/Layouts/Pages/page_start_screen.dart';
import 'package:BieDaalt/Routes/app_routes.dart';
import 'package:BieDaalt/views/bot_screen.dart';
import 'package:flutter/material.dart';
import 'package:BieDaalt/provider/room_data_provider.dart';
import 'package:BieDaalt/screens/create_room_screen.dart';
import 'package:BieDaalt/screens/game_screen.dart';
import 'package:BieDaalt/screens/home_screen.dart';
import 'package:BieDaalt/screens/join_room_screen.dart';
import 'package:BieDaalt/screens/main_menu_screen.dart';
import 'package:BieDaalt/utils/colors.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:BieDaalt/views/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('user');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        title: 'Бие Даалт',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
        ),
        initialRoute: Splash.routeName,
        onGenerateRoute: AppRoute().generateRoute,
      ),
    );
  }
}
