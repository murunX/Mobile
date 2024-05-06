import 'package:flutter/material.dart';
import 'package:mp_tictactoe/provider/room_data_provider.dart';
import 'package:mp_tictactoe/resources/socket_methods.dart';
import 'package:provider/provider.dart';

class RockPaperScissor extends StatefulWidget {
  const RockPaperScissor({Key? key}) : super(key: key);

  @override
  State<RockPaperScissor> createState() => _RockPaperScissorState();
}

class _RockPaperScissorState extends State<RockPaperScissor> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    // print("sda $context");
    // print("inistatsda");
    _socketMethods.makeChoiceListener(context);
  }

  // void makeChoice(String choice) {
  //   RoomDataProvider roomDataProvider =
  //       Provider.of<RoomDataProvider>(context, listen: false);
  //   _socketMethods.makeChoices(choice, roomDataProvider.roomData['_id']);
  // }

  void makeChoice(String choice, RoomDataProvider roomDataProvider) {
    _socketMethods.makeChoices(
      choice,
      roomDataProvider.roomData['_id'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomDataProvider>(
      builder: (context, roomDataProvider, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Сонгоно уу',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    makeChoice('Rock', roomDataProvider);
                  },
                  child: Image.asset(
                    'assets/rock_btn.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    makeChoice('Paper', roomDataProvider);
                  },
                  child: Image.asset(
                    'assets/paper_btn.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    makeChoice('Scissor', roomDataProvider);
                  },
                  child: Image.asset(
                    'assets/scissor_btn.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
