import 'package:flutter/material.dart';
import 'package:tic_tac_toe/win_message.dart';
import 'package:tic_tac_toe/win_screen.dart';
import 'consts.dart';
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
  bool hasCellListCreated = false;
  bool hasIconsFromBoardCreated = false;
  bool isX = true;
  bool hasGameStarted = false;
  bool hasWon = false;
  List iconsFromBoard = List();
  IconData circleIcon = Icons.panorama_fish_eye;
  IconData xIcon = Icons.clear;
  String winMessage = 'Congrats!';
  Offset startOffset;
  Offset endOffset;

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
        setState(() {
          print(i);
          hasGameStarted = false;
          hasWon = true;
          winMessage = '${isX == false ? '×' : '○'} Won Horizontally!';
          var sidePadding = 30;
          var boardSize = MediaQuery.of(context).size.width - (sidePadding * 2);
          var cellSize = boardSize / rowLength;
          var y = boardSize * (((i + 1) / rowLength) / rowLength) -
              (0.5 * cellSize);

          startOffset = Offset(0, y);
          endOffset = Offset(boardSize, y);
        });
        // Navigator.pushReplacementNamed(context, '/win',
        //     arguments:
        //         WinMessage('${isX == false ? '×' : '○'} Won Horizontally!'));
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
    // bool hasWon = false;
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
            startOffset = Offset(
                (MediaQuery.of(context).size.width - 60) *
                        (((j + 1 - (rowLength * 2))) / rowLength) -
                    (0.5 *
                        (MediaQuery.of(context).size.width - 60) /
                        rowLength),
                0);
            endOffset = Offset(
                (MediaQuery.of(context).size.width - 60) *
                        (((j + 1 - (rowLength * 2))) / rowLength) -
                    (0.5 *
                        (MediaQuery.of(context).size.width - 60) /
                        rowLength),
                MediaQuery.of(context).size.width - 60);
          });
          // Navigator.pushReplacementNamed(context, '/win',
          //     arguments:
          //         WinMessage('${isX == false ? '×' : '○'} Won Vertically!'));

          // hasWon = true;
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
            if (j == (rowLength * rowLength) - 1) {
              startOffset = Offset(0, 0);
              endOffset = Offset(MediaQuery.of(context).size.width - 60,
                  MediaQuery.of(context).size.width - 60);
            } else if (j == rowLength * 2) {
              startOffset = Offset(MediaQuery.of(context).size.width - 60, 0);
              endOffset = Offset(0, MediaQuery.of(context).size.width - 60);
            }
          });
          // Navigator.pushReplacementNamed(context, '/win',
          //     arguments:
          //         WinMessage('${isX == false ? '×' : '○'} Won Diagonally!'));

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
      //  return cellData[index];
    }
  }

  void fillCell(int i, IconData icon) {
    setState(() {
      iconsFromBoard[i] = icon;
    });
  }

  // void cellListCreator() {
  //   if (hasCellListCreated == false) {
  //     setState(() {
  //       hasCellListCreated = true;
  //       cellList = List<Widget>.generate(
  //         rowLength * rowLength,
  //         (i) => Cell(
  //           cellIndex: i,
  //           onTap: iconBrain,
  //         ),
  //       );
  //     });
  //   }
  // }

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
    // cellListCreator();
    iconsFromBoardResseter();

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
                margin: EdgeInsets.all(30),
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
            Slider(
              value: rowLength.toDouble(),
              min: 3,
              max: 15,
              activeColor: Colors.black,
              inactiveColor: Colors.grey,
              onChanged: (newVal) {
                setState(() {
                  print(MediaQuery.of(context).size.width);
                  if (!hasGameStarted) {
                    rowLength = newVal.floor();
                    hasCellListCreated = false;
                    hasIconsFromBoardCreated = false;
                  }
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
                // Navigator.pushReplacementNamed(context, '/win',
                //     arguments: WinMessage('Game Over!'));
                Navigator.pushReplacementNamed(context, '/play');
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 90, 30, 0),
          child: hasWon == true
              ? Container(
                  width: MediaQuery.of(context).size.width - 60,
                  height: MediaQuery.of(context).size.width - 60,
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

//
//85 for first boxes vert
//200 for second boxes vert
//310 for third boxes vert

//500 long and starting 30 down looks correct
class WinPainter extends CustomPainter {
  // final double rotation;
  final Offset startOffset;
  final Offset endOffset;
  WinPainter({
    // this.rotation,
    this.startOffset,
    this.endOffset,
  });
  @override
  void paint(Canvas canvas, Size size) {
    // canvas.translate(xPosition, kWinLineMidpointY);
    // canvas.rotate(rotation);
    // canvas.translate(-xPosition, -kWinLineMidpointY);

    Paint paintRules = Paint()
      ..color = Colors.black
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    // canvas.drawRect(
    //     Offset(kWinLineOffsetX, kWinLineOffsetY) &
    //         const Size(kWinLineWidth, kWinLineHeight),
    //     paintRules);

    canvas.drawLine(startOffset, endOffset, paintRules);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
