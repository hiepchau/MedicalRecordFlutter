// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

class GridCard extends StatelessWidget {
  final Image image;
  final String label;
  final Function onTap;

  const GridCard({Key key, this.image, this.label, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue[50],
          borderRadius: const BorderRadius.only(
            topLeft: const Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            image,
            const SizedBox(
              height: 15,
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Nexa Bold',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
