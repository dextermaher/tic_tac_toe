import 'package:flutter/material.dart';

class Cell extends StatefulWidget {
  final int cellIndex;
  final Function onTap;
  Cell({this.cellIndex, this.onTap});

  @override
  _CellState createState() => _CellState();
}

class _CellState extends State<Cell> {
  IconData displayIcon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          displayIcon = widget.onTap(widget.cellIndex);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
        ),
        child: Icon(
          displayIcon != null ? displayIcon : null,
        ),
      ),
    );
  }
}
