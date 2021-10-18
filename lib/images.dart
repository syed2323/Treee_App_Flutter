import 'package:flutter/material.dart';

class IImage extends StatelessWidget {
  final image;

  IImage(this.image);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 229.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(67), bottomLeft: Radius.circular(67)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.lightGreen.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 6),
            ),
          ],
          image: DecorationImage(
            image: NetworkImage(image),
            alignment: Alignment.centerLeft,
            fit: BoxFit.fill,
          )),
    );
  }
}
