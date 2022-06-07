import 'package:flutter/material.dart';
import 'package:medicalrecordapp/components/custom_text_field.dart';
import 'package:medicalrecordapp/components/rounded_button.dart';
import 'package:medicalrecordapp/constants.dart';
import 'package:medicalrecordapp/screens/user_dashboard_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:medicalrecordapp/services/authenticate.dart';
import 'package:toast/toast.dart';

import '../models/auth_user.dart';

class UserLoginScreen extends StatefulWidget {
  static String id = 'user_login';

  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  bool loadingIndicator = false;

  void showMessage(String txt){
    Toast.show(
      txt,
      duration: Toast.lengthLong,
      gravity: Toast.bottom,
    );
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        color: Colors.white,
        opacity: 0.9,
        progressIndicator: kWaveLoadingIndicator,
        inAsyncCall: loadingIndicator,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset(
                        'assets/images/medical_logo.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  CustomTextField(
                    label: 'E-mail',
                    hint: 'johndoe@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                    controller: this.email,
                  ),
                  CustomTextField(
                    label: 'Password',
                    hint: 'Type your password',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: this.password,
                  ),
                  RoundedButton(
                    text: 'Log In',
                    color: Colors.lightBlue[900],
                    onPressed: () async {
                      setState(() {
                        loadingIndicator = true;
                      });
                      final user = await Auth()
                          .signIn(this.email.text, this.password.text);
                      if (user.runtimeType == String) {
                        showMessage(user);}
                      else if (user.runtimeType == AppUser)
                        Navigator.pushNamed(context, UserDashboardScreen.id);
                      setState(() {
                        loadingIndicator = false;
                      });                     
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
