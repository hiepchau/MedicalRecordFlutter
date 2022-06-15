// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medicalrecordapp/components/custom_text_field.dart';
import 'package:medicalrecordapp/components/rounded_button.dart';
import 'package:medicalrecordapp/constants.dart';
import 'package:medicalrecordapp/screens/terms_and_conditions_screen.dart';
import 'package:medicalrecordapp/screens/user_dashboard_screen.dart';
import 'package:medicalrecordapp/services/authenticate.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

import '../../models/auth_user.dart';

class UserRegistrationScreen extends StatefulWidget {
  static String id = 'user_register';

  const UserRegistrationScreen({Key key}) : super(key: key);

  @override
  _UserRegistrationScreenState createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  TextEditingController mail = TextEditingController();
  TextEditingController pass = TextEditingController();

  bool loadingIndicator = false;
  bool checkedValue = false;

  void showMessage(String txt) {
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
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 200.0,
                      child: Image.asset('assets/images/medical_logo.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  CustomTextField(
                    label: 'E-mail',
                    hint: 'johndoe@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                    controller: mail,
                  ),
                  CustomTextField(
                    label: 'Password',
                    hint: 'Type your password',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: pass,
                  ),
                  Row(children: [
                    Checkbox(
                      value: checkedValue,
                      onChanged: (newValue) {
                        setState(() {
                          checkedValue = newValue;
                        });
                      },
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'I agree to the ',
                          style: kTextStyle.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'terms and conditions',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                  context, TermsAndConditionsScreen.id);
                            },
                          style: kTextStyle.copyWith(
                            color: Colors.lightBlue,
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ]),
                    ),
                  ]),
                  RoundedButton(
                    text: 'Register',
                    color: Colors.lightBlue[900],
                    onPressed: () async {
                      if (checkedValue) {
                        setState(() {
                          loadingIndicator = true;
                        });
                        final user =
                            await Auth().register(mail.text, pass.text);
                        if (user.runtimeType == String) {
                          showMessage(user);
                        } else if (user.runtimeType == AppUser) {
                          Navigator.pushNamed(context, UserDashboardScreen.id);
                        }
                        setState(() {
                          loadingIndicator = false;
                        });
                      }
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
