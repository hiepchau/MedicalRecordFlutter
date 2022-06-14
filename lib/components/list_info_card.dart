import 'package:flutter/material.dart';
import 'package:medicalrecordapp/constants.dart';

class ListInfoCard extends StatelessWidget {
  final String title;
  final String description;
  final Function onTap;

  const ListInfoCard({Key key, this.title, this.description, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: ListTile(
          title: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  title,
                  style: kTextStyle.copyWith(
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  description,
                  style: kTextStyle.copyWith(
                    fontFamily: 'Nexa',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
