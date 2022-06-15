// ignore_for_file: library_private_types_in_public_api

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:medicalrecordapp/components/rounded_button.dart';
import 'package:medicalrecordapp/screens/Authen/user_login_screen.dart';
import 'package:medicalrecordapp/screens/Authen/user_registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome';

  const WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Hero(
                        tag: 'logo',
                        child: Image.asset(
                          'assets/images/medical_logo.png',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText('Medical Record',
                              textStyle: const TextStyle(
                              fontSize: 50.0,
                              fontFamily: 'Nexa Bold',
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                            speed: const Duration(
                              milliseconds: 200,
                              )
                           ),
                        ]),
                          const Text(
                            'Electronic Health Record',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Nexa',
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 48.0,
                ),
                RoundedButton(
                  text: 'Log In',
                  color: Colors.lightBlue[900],
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      UserLoginScreen.id,
                    );
                  },
                ),
                RoundedButton(
                  text: 'Register',
                  color: Colors.lightBlue[700],
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      UserRegistrationScreen.id,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
