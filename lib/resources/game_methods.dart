import 'package:flutter/material.dart';
import 'package:BieDaalt/models/player.dart';
import 'package:BieDaalt/provider/room_data_provider.dart';
import 'package:BieDaalt/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class GameMethods {
  void checkWinner(BuildContext context, Socket socketClient) {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);

    String winner = '';

    // Get player choices
    String? player1Choice = roomDataProvider.player1.playerChoice;
    String? player2Choice = roomDataProvider.player2.playerChoice;

    // Check for Rock-Paper-Scissors win conditions
    if (player1Choice != null && player2Choice != null) {
      // Check win conditions
      if (player1Choice == player2Choice) {
        winner = '';
      } else if ((player1Choice == 'Rock' && player2Choice == 'Scissor') ||
          (player1Choice == 'Scissor' && player2Choice == 'Paper') ||
          (player1Choice == 'Paper' && player2Choice == 'Rock')) {
        winner = 'player1';
        // player1Point += 1;
        // showGameDialog(context, '${roomDataProvider.player1.nickname} Хожлоо');
      } else {
        winner = 'player2';
        // player2Point += 1;
        // showGameDialog(context, '${roomDataProvider.player2.nickname} Хожлоо');
      }
    }

    // Handle the winner

    if (winner == 'player1') {
      showGameDialog(context, '${roomDataProvider.player1.nickname} Хожлоо!');
      socketClient.emit('winner', {
        'winnerSocketId': roomDataProvider.player1.socketID,
        'roomId': roomDataProvider.roomData['_id'],
      });
    } else if (winner == 'player2') {
      showGameDialog(context, '${roomDataProvider.player2.nickname} Хожлоо!');
      socketClient.emit('winner', {
        'winnerSocketId': roomDataProvider.player2.socketID,
        'roomId': roomDataProvider.roomData['_id'],
      });
    } else {
      showGameDialog(context, 'Тэнцсэн');
    }
  }

  void showGameDialog(BuildContext context, String text) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(text),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Дахин тоглох',
                ),
              ),
              TextButton(
                onPressed: () {
                  navigateToMainScreen(context);
                },
                child: const Text(
                  'Буцах',
                ),
              ),
            ],
          );
        });
  }

  void clearBoard(BuildContext context) {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);

    roomDataProvider.player1.playerChoice = null;
    roomDataProvider.player2.playerChoice = null;
  }
}
