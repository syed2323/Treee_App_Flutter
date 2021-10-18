import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String name;
  final String location;

  Profile(this.name, this.location);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        width: 360,
        child: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                child: Text(
                  name,
                  style: TextStyle(fontSize: (26), fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: EdgeInsets.only(right: 40),
            ),
            Container(
                width: double.infinity,
                child: Text(location, style: TextStyle(fontSize: 18)))
          ],
        ));
  }
}
