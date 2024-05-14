import 'package:BieDaalt/Global/functions.dart';
import 'package:BieDaalt/Layouts/Pages/page_start_screen.dart';
import 'package:BieDaalt/Layouts/Widgets/widget_gradient%20_button.dart';
import 'package:BieDaalt/Resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:BieDaalt/responsive/responsive.dart';
import 'package:BieDaalt/screens/create_room_screen.dart';
import 'package:BieDaalt/screens/join_room_screen.dart';
import 'package:BieDaalt/widgets/custom_button.dart';
import 'package:hive/hive.dart';

class MainMenuScreen extends StatefulWidget {
  static String routeName = '/main-menu';
  const MainMenuScreen({Key? key}) : super(key: key);
  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  final myBox = Hive.box('user');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: background(Str.image),
        child: Column(
          children: [
            // Flappy bird text
            Container(
                margin: EdgeInsets.only(top: size.height * 0.25),
                child: myText("JanKenPon", Colors.white, 70)),
            _buttons(),
            AboutUs(
              size: size,
            )
          ],
        ),
      ),
    );
  }
}

// three buttons
Column _buttons() {
  return Column(
    children: [
      Button(
        buttonType: "text",
        buttonText: "Өрөө нээх",
        height: 60,
        width: 278,
        icon: Icon(
          Icons.play_arrow_rounded,
          size: 60,
          color: Colors.green,
        ),
        page: Str.create,
      ),
      Button(
        buttonType: "text",
        buttonText: "Өрөөрүү орох",
        height: 60,
        width: 278,
        icon: Icon(
          Icons.play_arrow_rounded,
          size: 60,
          color: Colors.green,
        ),
        page: Str.join,
      ),
    ],
  );
}
