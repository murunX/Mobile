import 'package:flutter/material.dart';
import 'package:BieDaalt/utils/game.dart';
import 'package:BieDaalt/views/bot_play_screen.dart';
import 'package:BieDaalt/widgets/button.dart';

class BotScreen extends StatefulWidget {
  const BotScreen({Key? key}) : super(key: key);
  // static String routeName = '/bot-screen';
  @override
  _BotScreenState createState() => _BotScreenState();
}

class _BotScreenState extends State<BotScreen> {
  @override
  Widget build(BuildContext context) {
    double btnWidth = MediaQuery.of(context).size.width / 2 - 40;
    return Scaffold(
      backgroundColor: Color(0xFF060A47),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 5.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Оноо",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${Game.gameScore}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            /* Setting the Game play pad */
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              child: Center(
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: MediaQuery.of(context).size.width / 2 -
                          (btnWidth / 2) -
                          20, // we soustract the half of ther widget size and the half of the padding,
                      child: Hero(
                        tag: "Rock",
                        child: gameBtn(() {
                          print("Та чулуу сонголоо");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BotChooseScreen(GameChoice("Rock")),
                            ),
                          );
                        }, "assets/rock_btn.png", btnWidth),
                      ),
                    ),
                    Positioned(
                      top: btnWidth,
                      left: MediaQuery.of(context).size.width / 2 -
                          btnWidth -
                          40, // we soustract the half of ther widget size and the half of the padding,
                      child: Hero(
                        tag: "Scisors",
                        child: gameBtn(() {
                          print("Та хайч сонголоо");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BotChooseScreen(GameChoice("Scisors")),
                            ),
                          );
                        }, "assets/scissor_btn.png", btnWidth),
                      ),
                    ),
                    Positioned(
                      top: btnWidth,
                      right: MediaQuery.of(context).size.width / 2 -
                          btnWidth -
                          40, // we soustract the half of ther widget size and the half of the padding,
                      child: Hero(
                        tag: "Paper",
                        child: gameBtn(() {
                          print("Та цаас сонголоо");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BotChooseScreen(GameChoice("Paper")),
                            ),
                          );
                        }, "assets/paper_btn.png", btnWidth),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                padding: EdgeInsets.all(24.0),
                onPressed: () => navigateToMainScreen(context),
                shape: StadiumBorder(
                    side: BorderSide(color: Colors.white, width: 5)),
                child: Text(
                  "Буцах",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
