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

class UserRegistrationScreen extends StatefulWidget {
  static String id = 'user_register';

  @override
  _UserRegistrationScreenState createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  bool loadingIndicator = false;
  bool checkedValue = false;

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
                      child: Image.asset('assets/images/lifeline_logo.png'),
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
                  CheckboxListTile(
                    title: RichText(
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
                            color: Colors.green,
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ]),
                    ),
                    value: checkedValue,
                    onChanged: (newValue) {
                      setState(() {
                        checkedValue = newValue;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  RoundedButton(
                    text: 'Register',
                    color: Colors.green[900],
                    onPressed: () async {
                      if (checkedValue) {
                        setState(() {
                          loadingIndicator = true;
                        });
                        try {
                          final user = await Auth()
                              .register(this.email.text, this.password.text);
                          if (user != null)
                            Navigator.pushNamed(
                                context, UserDashboardScreen.id);
                          setState(() {
                            loadingIndicator = false;
                          });
                        } catch (e) {
                          print(e);
                          Toast.show(
                            e.message,
                            duration: Toast.lengthShort,
                            gravity: Toast.top,
                          );
                        }
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
