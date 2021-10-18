import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  final String plantedTree;

  Summary(this.plantedTree);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 130,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 120),
          ),
          Container(
            height: 60,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(17),
                  bottomLeft: Radius.circular(17),
                  topRight: Radius.circular(17),
                  bottomRight: Radius.circular(17)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.lightGreen.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            //  person user count
            child: Icon(
              Icons.person,
              color: Colors.green,
              size: 50,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            height: 60,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(17),
                  bottomLeft: Radius.circular(17),
                  topRight: Radius.circular(17),
                  bottomRight: Radius.circular(17)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.lightGreen.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Text(
              plantedTree,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
          ),
          Container(
            height: 60,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(17),
                  bottomLeft: Radius.circular(17),
                  topRight: Radius.circular(17),
                  bottomRight: Radius.circular(17)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.lightGreen.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Icon(
              Icons.eco_sharp,
              color: Colors.green,
              size: 50,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            height: 60,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(17),
                  bottomLeft: Radius.circular(17),
                  topRight: Radius.circular(17),
                  bottomRight: Radius.circular(17)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.lightGreen.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Text(
              plantedTree,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
