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
  final int rowLength = 3;
  List<Widget> cellList = List();
  bool hasCreated = false;
  bool isX = true;
  List iconsFromBoard = List();

  void checkForLine(
    int index,
  ) {
    //check for cross win
    if (iconsFromBoard[index] == Icons.clear) {
      // checkSurrounding(index, Icons.clear);
      checkManager(Icons.clear);
    }
    //check for circle win
    else if (iconsFromBoard[index] == Icons.panorama_fish_eye) {
      // checkSurrounding(index, Icons.clear);
      checkManager(Icons.panorama_fish_eye);
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
          rowElements.add(icon);
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
            rowElements.add(icon);
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
            rowElements.add(icon);
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

  // void getBoardData() {
  //   List keyList = cellData.keys.toList();
  //   List valueList = cellData.values.toList();
  //   int indexOfCounter = 0;
  //   setState(() {
  //     iconsFromBoard.clear();
  //   });
  //   for (int i = 0; i < rowLength ^ 2; i++) {
  //     if (keyList.contains(i) && iconsFromBoard.contains(i)) {
  //       if (keyList.indexOf(i) ==
  //           valueList.indexOf(Icons.clear, indexOfCounter) && iconsFromBoard[i] == Icons.clear) {
  //         indexOfCounter++;
  //         setState(() {
  //           iconsFromBoard[i] = Icons.clear;
  //         });
  //       } else {
  //         setState(() {
  //           iconsFromBoard[i] = Icons.panorama_fish_eye;
  //         });
  //       }
  //     }
  //   }
  // }

  void resetter() {
    print('resetting');
    setState(() {
      cellList.clear();
      hasCreated = false;
      isX = true;
      iconsFromBoard.clear();
    });

    cellListCreator();
  }

  IconData iconBrain(int index) {
    // checkForWin(index);
    if (iconsFromBoard[index] == '') {
      if (isX) {
        //next click is circle
        setState(() {
          isX = !isX;
        });
        fillCell(index, Icons.clear);

        checkForLine(index);
        //checkAgainst(Icons.clear);

        return Icons.clear;
      } else {
        //next click is cross
        setState(() {
          isX = !isX;
        });
        fillCell(index, Icons.panorama_fish_eye);
        //checkAgainst(Icons.panorama_fish_eye);

        checkForLine(index);

        return Icons.panorama_fish_eye;
      }
    } else {
      checkForLine(index);
      return iconsFromBoard[index];
      //  return cellData[index];
    }
  }

  void fillCell(int i, IconData icon) {
    setState(() {
      // cellData.putIfAbsent(i, () => icon);
      iconsFromBoard[i] = icon;
    });
  }

  void cellListCreator() {
    if (hasCreated == false) {
      setState(() {
        hasCreated = true;
        cellList = List<Widget>.generate(
          rowLength * rowLength,
          (i) => Cell(
            cellIndex: i,
            onTap: iconBrain,
          ),
        );
      });
      iconsFromBoardResseter();
    }
  }

  void iconsFromBoardResseter() {
    setState(() {
      iconsFromBoard = List.generate(
        rowLength * rowLength,
        (i) => '',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    cellListCreator();
    return Scaffold(
      appBar: AppBar(
        title: Text("Let's Play!"),
      ),
      body: Column(
        children: [
          (GridView.count(
            crossAxisCount: rowLength,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: cellList,
          )),
          FlatButton(
            child: Text('Restart'),
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
