import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Container(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Welcome!',
                  style: TextStyle(color: Colors.black, fontSize: 60),
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
