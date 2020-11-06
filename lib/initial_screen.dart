import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Welcome!'),
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
