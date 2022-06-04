import 'package:flutter/material.dart';
import 'package:medicalrecordapp/constants.dart';
import 'package:medicalrecordapp/screens/welcome_screen.dart';
import 'package:medicalrecordapp/services/authenticate.dart';

class LogOutAlertDialog extends StatelessWidget {
  final BuildContext context;

  LogOutAlertDialog({
    @required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Log Out',
        style: kTextStyle.copyWith(
          fontSize: 24,
        ),
      ),
      content: Text(
        'Are you sure you want to log out?',
        style: kTextStyle.copyWith(
          fontSize: 18,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Auth().signout();
            Navigator.pushNamed(context, WelcomeScreen.id);
          },
          child: Text(
            'Yes',
            style: kTextStyle.copyWith(color: Colors.green, fontSize: 18),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'No',
            style: kTextStyle.copyWith(color: Colors.green, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
