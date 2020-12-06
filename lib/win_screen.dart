import 'package:flutter/material.dart';
import 'package:tic_tac_toe/win_message.dart';

class WinScreen extends StatelessWidget {
  static const routeName = '/win';
  @override
  Widget build(BuildContext context) {
    final WinMessage winText = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Container(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  winText.winMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 60),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.black,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(3, 10, 3, 10),
                    child: Text(
                      'Play!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/play');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
