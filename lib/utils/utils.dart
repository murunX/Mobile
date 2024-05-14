import 'package:flutter/material.dart';
import 'package:BieDaalt/resource/socket_methods.dart';
import 'package:BieDaalt/screens/main_menu_screen.dart';

final SocketMethods _socketMethods = SocketMethods();
final TextEditingController _gameIdController = TextEditingController();
final TextEditingController _nameController = TextEditingController();

void navigateToMainScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MainMenuScreen()),
  );
}

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

void showGameDialog(
  BuildContext context,
  String text,
  String player1ChoiceImagePath,
  String player2ChoiceImagePath,
) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(text),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Player 1 Choice:'),
            Image.asset(
              player1ChoiceImagePath,
              width: 50,
              height: 50,
            ),
            SizedBox(height: 10),
            Text('Player 2 Choice:'),
            Image.asset(
              player2ChoiceImagePath,
              width: 50,
              height: 50,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _socketMethods.exitRoom(
                _nameController.text,
                _gameIdController.text,
              );
              Navigator.pop(context);
            },
            child: const Text('Буцах'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Үргэлжлүүлэх'),
          ),
        ],
      );
    },
  );
}
