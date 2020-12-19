import 'package:flutter/material.dart';
import 'cell.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/play';
  final double boardsize;
  MyHomePage({Key key, this.boardsize}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int rowLength = 3;
  bool hasBoardSizeCreated = false;
  bool hasCellListCreated = false;
  bool hasIconsFromBoardCreated = false;
  bool isX = true;
  bool hasGameStarted = false;
  bool hasWon = false;
  List iconsFromBoard = List();
  IconData circleIcon = Icons.panorama_fish_eye;
  IconData xIcon = Icons.clear;
  String winMessage = 'Congrats!';
  double screenSize;
  double sidePadding = 30;
  Offset startOffset;
  Offset endOffset;

  void widthInit() {
    if (screenSize == null) {
      if (MediaQuery.of(context).size.width <
          MediaQuery.of(context).size.height) {
        setState(() {
          screenSize = MediaQuery.of(context).size.width;
        });
      } else {
        setState(() {
          MediaQuery.of(context).size.height;
        });
      }
    }
  }

  void setBoardSize() {
    if (!hasBoardSizeCreated) {
      setState(() {
        hasBoardSizeCreated = true;
        rowLength = widget.boardsize.toInt();
      });
    }
  }

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

/*
HOW CHECK HORIZONTAL WORKS:
1. the icon taken in is the only icon that it checks for a win scenario
2. it creates a list that will be used to keep the checked elements
3. starts a loop that loops through all cells in the board
4. if the cell being checked has that icon in it, true is added to the list
   if it does not have the icon, false is added
5. if the list has elements equal to the number of cells in a row and there are 
   no falses in the list, then the game has been won if that is not the case,
   then the list is cleared as long as it has elements equal to the number of 
   cells in a row

IN THE ON WIN
  in the on win, most things are self explanatory, but the vars and below 
  are used to find the correct points for the win line
*/
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
        setState(() {
          print(i);
          hasGameStarted = false;
          hasWon = true;
          winMessage = '${isX == false ? '×' : '○'} Won Horizontally!';
          var boardSize = screenSize - (sidePadding * 2);
          var cellSize = boardSize / rowLength;
          var y = boardSize * (((i + 1) / rowLength) / rowLength) -
              (0.5 * cellSize);

          startOffset = Offset(0, y);
          endOffset = Offset(boardSize, y);
        });
        break;
      }
      if (rowElements.length % rowLength == 0) {
        setState(() {
          rowElements.clear();
        });
      }
    }
  }

/*
HOW CHECK VERTICAL WORKS:
1. the icon taken in is the only icon that it checks for a win scenario
2. it creates a list that will be used to keep the checked elements
3. starts a loop that loops through the number of cells in a row
4. starts a loop that loops through all cells in the board, increasing 
   down a row every time. this is so that it checks one row, then the outer
   loop moves onto the next row
5. if the cell being checked has that icon in it, true is added to the list
   if it does not have the icon, false is added
6. if the list has elements equal to the number of cells in a row and there are 
   no falses in the list, then the game has been won if that is not the case,
   then the list is cleared as long as it has elements equal to the number of 
   cells in a row
   
IN THE ON WIN
  in the on win, most things are self explanatory, but the vars and below 
  are used to find the correct points for the win line
*/
  void checkVertical(IconData icon) {
    List rowElements = [];
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
          setState(() {
            hasGameStarted = false;
            hasWon = true;
            winMessage = '${isX == false ? '×' : '○'} Won Vertically!';

            var boardSize = screenSize - (sidePadding * 2);
            var cellSize = boardSize / rowLength;
            var x = boardSize * ((j + 1 - (rowLength * 2)) / rowLength) -
                (0.5 * cellSize);

            startOffset = Offset(x, 0);
            endOffset = Offset(x, boardSize);
          });
          break;
        }
        if (rowElements.length % rowLength == 0) {
          setState(() {
            rowElements.clear();
          });
        }
      }
      if (hasWon) {
        break;
      }
    }
  }

/*
HOW CHECK VERTICAL WORKS:
1. the icon taken in is the only icon that it checks for a win scenario
2. it creates a list that will be used to keep the checked elements
3. the starting value determines the cell that is first checked
4. the increase decrease is the amount that the loop should increase or
   decrease by every loop
5. starts a loop that loops through the number of cells in a row
6. starts a loop that loops through all cells in the board, increasing 
   down a row every time. this is so that it checks one row, then the outer
   loop moves onto the next row
7. if the cell being checked has that icon in it, true is added to the list
   if it does not have the icon, false is added
8. if the list has elements equal to the number of cells in a row and there are 
   no falses in the list, then the game has been won if that is not the case,
   then the list is cleared as long as it has elements equal to the number of 
   cells in a row
9. the starting value is changed to check starting with the last cell of the 
   first row
10. the increase decrease previously increased by one row down and one cell right,
    it now increas by one row down and one cell left
   
IN THE ON WIN
  in the on win, most things are self explanatory, but the vars and below 
  are used to find the correct points for the win line
*/
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
          setState(() {
            hasGameStarted = false;
            hasWon = true;
            winMessage = '${isX == false ? '×' : '○'} Won Diagonally!';

            var boardSize = screenSize - (sidePadding * 2);

            //if the last index checked in the win is the last cell
            if (j == (rowLength * rowLength) - 1) {
              startOffset = Offset(0, 0);
              endOffset = Offset(boardSize, boardSize);
              //if the last index checked in the win is the first cell of last row
            } else if (j + 1 == rowLength * 2 + 1) {
              startOffset = Offset(boardSize, 0);
              endOffset = Offset(0, boardSize);
            }
          });

          break;
        }
        if (rowElements.length % rowLength == 0) {
          setState(() {
            rowElements.clear();
          });
        }
      }
      if (!rowElements.contains(false) && rowElements.length == rowLength) {
        break;
      }
      startingValue = rowLength - 1;
      increaseDecrease = rowLength - 1;
    }
  }

  IconData iconBrain(int index) {
    if (!hasGameStarted) {
      setState(() {
        hasGameStarted = true;
      });
    }
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
    }
  }

  void fillCell(int i, IconData icon) {
    setState(() {
      iconsFromBoard[i] = icon;
    });
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
    setBoardSize();
    iconsFromBoardResseter();
    widthInit();
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Text("Let's Play!"),
      ),
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SafeArea(
              child: Container(
                margin: EdgeInsets.all(sidePadding),
                decoration: BoxDecoration(
                  border: Border.all(width: 10, color: Colors.deepPurple),
                ),
                child: (GridView.count(
                  crossAxisCount: rowLength,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: List<Widget>.generate(
                    rowLength * rowLength,
                    (i) => Cell(
                      cellIndex: i,
                      onTap: iconBrain,
                    ),
                  ),
                )),
              ),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(
                        boardsize: rowLength.toDouble(),
                      ),
                    ));
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 130, 30, 0),
          child: hasWon == true
              ? Container(
                  width: screenSize - (sidePadding * 2),
                  height: screenSize - (sidePadding * 2),
                  child: CustomPaint(
                    painter: WinPainter(
                      startOffset: startOffset,
                      endOffset: endOffset,
                    ),
                  ),
                )
              : null,
        ),
        Center(
          child: hasWon == true
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: hasWon == true ? Color(0xbb000000) : null,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      winMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : null,
        )
      ]),
    );
  }
}

class WinPainter extends CustomPainter {
  final Offset startOffset;
  final Offset endOffset;
  WinPainter({
    this.startOffset,
    this.endOffset,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Paint paintRules = Paint()
      ..color = Colors.black
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    canvas.drawLine(startOffset, endOffset, paintRules);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
