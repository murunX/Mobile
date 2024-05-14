import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:BieDaalt/models/player.dart';
import 'package:BieDaalt/provider/room_data_provider.dart';
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
      } else {
        winner = 'player2';
      }

      // Show dialog based on the winner
      showGameDialog(context, winner, roomDataProvider, socketClient);
    }
  }

  void showGameDialog(BuildContext context, String winner,
      RoomDataProvider roomDataProvider, Socket socketClient) {
    if (winner == 'player1') {
      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text('${roomDataProvider.player1.nickname} Хожлоо!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('${roomDataProvider.player1.nickname} сонголоо:'),
                  SizedBox(
                    width: 50, // Adjust the width as needed
                    height: 50, // Adjust the height as needed
                    child: Image.asset(_getImageAssetPath(
                        roomDataProvider.player1.playerChoice!)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('${roomDataProvider.player2.nickname} сонголоо:'),
                  SizedBox(
                    width: 50, // Adjust the width as needed
                    height: 50, // Adjust the height as needed
                    child: Image.asset(_getImageAssetPath(
                        roomDataProvider.player2.playerChoice!)),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: Text('Дахин оролдох'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: Text('Буцах'),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
              },
            ),
          ],
        ),
      );
      socketClient.emit('winner', {
        'winnerSocketId': roomDataProvider.player1.socketID,
        'roomId': roomDataProvider.roomData['_id'],
      });
    } else if (winner == 'player2') {
      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text('${roomDataProvider.player2.nickname} Хожлоо!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('${roomDataProvider.player1.nickname} сонголоо:'),
                  SizedBox(
                    width: 50, // Adjust the width as needed
                    height: 50, // Adjust the height as needed
                    child: Image.asset(_getImageAssetPath(
                        roomDataProvider.player1.playerChoice!)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('${roomDataProvider.player2.nickname} сонголоо:'),
                  SizedBox(
                    width: 50, // Adjust the width as needed
                    height: 50, // Adjust the height as needed
                    child: Image.asset(_getImageAssetPath(
                        roomDataProvider.player2.playerChoice!)),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: Text('Дахин оролдох'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: Text('Буцах'),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
          ],
        ),
      );
      socketClient.emit('winner', {
        'winnerSocketId': roomDataProvider.player2.socketID,
        'roomId': roomDataProvider.roomData['_id'],
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text('Тэнцсэн'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('${roomDataProvider.player1.nickname} сонголоо:'),
                  SizedBox(
                    width: 50, // Adjust the width as needed
                    height: 50, // Adjust the height as needed
                    child: Image.asset(_getImageAssetPath(
                        roomDataProvider.player1.playerChoice!)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('${roomDataProvider.player2.nickname} сонголоо:'),
                  SizedBox(
                    width: 50, // Adjust the width as needed
                    height: 50, // Adjust the height as needed
                    child: Image.asset(_getImageAssetPath(
                        roomDataProvider.player2.playerChoice!)),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: Text('Дахин оролдох'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: Text('Буцах'),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
          ],
        ),
      );
    }
  }

  String _getImageAssetPath(String choice) {
    switch (choice) {
      case 'Rock':
        return 'assets/rock_btn.png';
      case 'Paper':
        return 'assets/paper_btn.png';
      case 'Scissor':
        return 'assets/scissor_btn.png';
      default:
        return '';
    }
  }

  void clearBoard(BuildContext context) {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);

    roomDataProvider.player1.playerChoice = null;
    roomDataProvider.player2.playerChoice = null;
  }
}
