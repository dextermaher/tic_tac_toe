import 'package:flutter/material.dart';
import 'package:tic_tac_toe/win_message.dart';

class WinScreen extends StatelessWidget {
  static const routeName = '/win';
  @override
  Widget build(BuildContext context) {
    final WinMessage winText = ModalRoute.of(context).settings.arguments;
    return Container(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              winText.winMessage,
            ),
            FlatButton(
              child: Text(
                'Play!',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/play');
              },
            ),
          ],
        ),
      ),
    );
  }
}
