// ignore_for_file: prefer_const_constructors
import 'package:BieDaalt/Layouts/Pages/page_game.dart';
import 'package:BieDaalt/Layouts/Pages/page_settings.dart';
import 'package:BieDaalt/screens/create_room_screen.dart';
import 'package:BieDaalt/screens/game_screen.dart';
import 'package:BieDaalt/screens/join_room_screen.dart';
import 'package:BieDaalt/screens/main_menu_screen.dart';
import 'package:BieDaalt/views/bot_screen.dart';
import 'package:BieDaalt/views/splash_screen.dart';
import 'package:flutter/material.dart';
import '../Layouts/Pages/page_rate_us.dart';
import '../Layouts/Pages/page_start_screen.dart';
import '../Resources/strings.dart';

class AppRoute {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Str.home:
        return MaterialPageRoute(builder: (_) => StartScreen());
      case Str.Bot:
        return MaterialPageRoute(builder: (_) => BotScreen());
      case Str.main:
        return MaterialPageRoute(builder: (_) => MainMenuScreen());
      case Str.create:
        return MaterialPageRoute(builder: (_) => CreateRoomScreen());
      case Str.join:
        return MaterialPageRoute(builder: (_) => JoinRoomScreen());
      case Str.game:
        return MaterialPageRoute(builder: (_) => GameScreen());
      case Str.splash:
        return MaterialPageRoute(builder: (_) => Splash());
      case Str.rateUs:
        return MaterialPageRoute(builder: (_) => RateUs());
      case Str.settings:
        return MaterialPageRoute(builder: (_) => Settings());
      default:
        _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Error Page"),
            backgroundColor: Colors.redAccent,
          ),
          body: Center(
            child: Text("Error"),
          ),
        );
      },
    );
  }
}
