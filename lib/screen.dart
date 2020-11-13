import 'package:flutter/material.dart';
import 'package:tic_tac_toe/win_message.dart';
import 'package:tic_tac_toe/win_screen.dart';
import 'cell.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/play';
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int rowLength = 3;
  List<Widget> cellList = List();
  bool hasCellListCreated = false;
  bool hasIconsFromBoardCreated = false;
  bool isX = true;
  List iconsFromBoard = List();
  IconData circleIcon = Icons.panorama_fish_eye;
  IconData xIcon = Icons.clear;

  void checkForLine(
    int index,
  ) {
    //check for cross win
    if (iconsFromBoard[index] == xIcon) {
      checkManager(xIcon);
    }
    //check for circle win
    else if (iconsFromBoard[index] == circleIcon) {
      checkManager(circleIcon);
    }
  }

  void checkManager(IconData icon) {
    // getBoardData();
    checkHorizontal(icon);
    checkVertical(icon);
    checkDiag(icon);
  }

  void checkHorizontal(IconData icon) {
    List rowElements = [];
    for (int i = 0; i < rowLength * rowLength; i++) {
      if (iconsFromBoard[i] == icon) {
        setState(() {
          rowElements.add(true);
        });
      } else {
        setState(() {
          rowElements.add(false);
        });
      }
      if (!rowElements.contains(false) && rowElements.length == rowLength) {
        print('horizontal win');
        Navigator.pushNamed(context, '/win',
            arguments: WinMessage('Won Horizontally!'));
        break;
      }
      if (rowElements.length % rowLength == 0) {
        setState(() {
          rowElements.clear();
        });
      }
    }
  }

  void checkVertical(IconData icon) {
    List rowElements = [];
    bool hasWon = false;
    for (int i = 0; i < rowLength; i++) {
      for (int j = i; j < rowLength * rowLength; j += rowLength) {
        if (iconsFromBoard[j] == icon) {
          setState(() {
            rowElements.add(true);
          });
        } else {
          setState(() {
            rowElements.add(false);
          });
        }
        if (!rowElements.contains(false) && rowElements.length == rowLength) {
          print('win vert $j');
          Navigator.pushNamed(context, '/win',
              arguments: WinMessage('Won Vertically!'));

          hasWon = true;
          break;
        }
        if (rowElements.length % rowLength == 0) {
          setState(() {
            rowElements.clear();
          });
        }
      }
      if (hasWon) {
        print('win vert external $i');
        break;
      }
    }
  }

  void checkDiag(IconData icon) {
    List rowElements = [];
    var startingValue = 0;
    int increaseDecrease = rowLength + 1;
    for (int i = 0; i < 2; i++) {
      for (int j = startingValue;
          j < rowLength * rowLength;
          j += increaseDecrease) {
        if (iconsFromBoard[j] == icon) {
          setState(() {
            rowElements.add(true);
          });
        } else {
          setState(() {
            rowElements.add(false);
          });
        }
        if (!rowElements.contains(false) && rowElements.length == rowLength) {
          print('win diag $j');
          Navigator.pushNamed(context, '/win',
              arguments: WinMessage('Won Diagonally!'));

          break;
        }
        if (rowElements.length % rowLength == 0) {
          setState(() {
            rowElements.clear();
          });
        }
      }
      if (!rowElements.contains(false) && rowElements.length == rowLength) {
        print('win diag $i');
        break;
      }
      startingValue = rowLength - 1;
      increaseDecrease = rowLength - 1;
    }
  }

  IconData iconBrain(int index) {
    if (iconsFromBoard[index] == '') {
      if (isX) {
        //next click is circle
        setState(() {
          isX = !isX;
        });
        fillCell(index, xIcon);

        checkForLine(index);

        return xIcon;
      } else {
        //next click is cross
        setState(() {
          isX = !isX;
        });
        fillCell(index, circleIcon);

        checkForLine(index);

        return circleIcon;
      }
    } else {
      checkForLine(index);
      return iconsFromBoard[index];
      //  return cellData[index];
    }
  }

  void fillCell(int i, IconData icon) {
    setState(() {
      iconsFromBoard[i] = icon;
    });
  }

  void cellListCreator() {
    if (hasCellListCreated == false) {
      setState(() {
        hasCellListCreated = true;
        cellList = List<Widget>.generate(
          rowLength * rowLength,
          (i) => Cell(
            cellIndex: i,
            onTap: iconBrain,
          ),
        );
      });
    }
  }

  void iconsFromBoardResseter() {
    if (hasIconsFromBoardCreated == false) {
      setState(() {
        iconsFromBoard = List.generate(
          rowLength * rowLength,
          (i) => '',
        );
        hasIconsFromBoardCreated = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    cellListCreator();
    iconsFromBoardResseter();

    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Text("Let's Play!"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SafeArea(
            child: Container(
              margin: EdgeInsets.all(30),
              decoration: BoxDecoration(
                border: Border.all(width: 10, color: Colors.deepPurple),
              ),
              child: (GridView.count(
                crossAxisCount: rowLength,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: cellList,
              )),
            ),
          ),
          Slider(
            value: rowLength.toDouble(),
            min: 3,
            max: 15,
            activeColor: Colors.black,
            inactiveColor: Colors.grey,
            onChanged: (newVal) {
              setState(() {
                rowLength = newVal.floor();
                hasCellListCreated = false;
                hasIconsFromBoardCreated = false;
              });
            },
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.black,
            textColor: Colors.white,
            child: Container(
              padding: EdgeInsets.fromLTRB(3, 10, 3, 10),
              child: Text(
                'Restart',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onPressed: () {
              // resetter();
              Navigator.pushNamed(context, '/win',
                  arguments: WinMessage('Game Over!'));
            },
          ),
        ],
      ),
    );
  }
}
