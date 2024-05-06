// game_screen.dart
import 'package:flutter/material.dart';
import 'package:BieDaalt/provider/room_data_provider.dart';
import 'package:BieDaalt/resources/socket_methods.dart';
import 'package:BieDaalt/views/scoreboard.dart';
import 'package:BieDaalt/views/tictactoe_board.dart';
import 'package:BieDaalt/views/waiting_lobby.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Scaffold(
      body: roomDataProvider.roomData['isJoin']
          ? const WaitingLobby()
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Scoreboard(),
                  RockPaperScissor(),
                ],
              ),
            ),
    );
  }
}
