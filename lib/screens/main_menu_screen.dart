import 'package:flutter/material.dart';
import 'package:BieDaalt/responsive/responsive.dart';
import 'package:BieDaalt/screens/create_room_screen.dart';
import 'package:BieDaalt/screens/join_room_screen.dart';
import 'package:BieDaalt/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = '/main-menu';
  const MainMenuScreen({Key? key}) : super(key: key);

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              onTap: () => createRoom(context),
              text: 'Өрөө Нээх',
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: () => joinRoom(context),
              text: 'Өрөөрүү орох',
            ),
          ],
        ),
      ),
    );
  }
}
