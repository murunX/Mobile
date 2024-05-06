import 'package:flutter/material.dart';
import 'package:BieDaalt/responsive/responsive.dart';
import 'package:BieDaalt/screens/create_room_screen.dart';
import 'package:BieDaalt/screens/join_room_screen.dart';
import 'package:BieDaalt/screens/main_menu_screen.dart';
import 'package:BieDaalt/views/bot_screen.dart';
import 'package:BieDaalt/widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  void navigateToBotScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BotScreen()),
    );
  }

  void navigateToMainScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainMenuScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_image.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Responsive(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                onTap: () => navigateToBotScreen(context),
                text: 'Боттой тоглох',
              ),
              const SizedBox(height: 20),
              CustomButton(
                onTap: () => navigateToMainScreen(context),
                text: 'Oнлайнаар тоглох',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
