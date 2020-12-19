import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double sliderValue = 3;

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
                Text(
                  'Number of cells: ${sliderValue.toInt() * sliderValue.toInt()}',
                  style: TextStyle(color: Colors.black, fontSize: 60),
                ),
                Slider(
                  value: sliderValue,
                  min: 3,
                  max: 20,
                  onChanged: (newValue) {
                    setState(() {
                      sliderValue = newValue.floor().toDouble();
                    });
                  },
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(
                            boardsize: sliderValue,
                          ),
                        ));
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
