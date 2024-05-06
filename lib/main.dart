import 'package:flutter/material.dart';
import 'package:BieDaalt/provider/room_data_provider.dart';
import 'package:BieDaalt/screens/create_room_screen.dart';
import 'package:BieDaalt/screens/game_screen.dart';
import 'package:BieDaalt/screens/home_screen.dart';
import 'package:BieDaalt/screens/join_room_screen.dart';
import 'package:BieDaalt/screens/main_menu_screen.dart';
import 'package:BieDaalt/utils/colors.dart';
import 'package:BieDaalt/views/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
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
        routes: {
          MainMenuScreen.routeName: (context) => const MainMenuScreen(),
          JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
          CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
          GameScreen.routeName: (context) => const GameScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          Splash.routeName: (context) => const Splash(),
        },
      ),
    );
  }
}
