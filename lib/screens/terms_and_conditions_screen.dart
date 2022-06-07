// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:medicalrecordapp/constants.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  static String id = 'terms_and_conditions';

  const TermsAndConditionsScreen({Key key}) : super(key: key);
  @override
  _TermsAndConditionsScreenState createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          title: Row(
            children: [
              SizedBox(
                height: 40.0,
                child: Image.asset(
                  'assets/images/medical_logo.png',
                ),
              ),
              Center(
                child: Text(
                  'Terms & Conditions',
                  style: kTextStyle.copyWith(
                    color: Colors.black,
                    fontFamily: 'Nexa Bold',
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.black54,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: AutoSizeText(
                      'Terms and conditions for proper usage of Medical Record application:',
                      style: kTextStyle.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nexa Bold',
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: AutoSizeText(
                      '-  Medical Record will access device location through GPS.',
                      style: kTextStyle.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: AutoSizeText(
                      '-  Medical Record will access phone camera for scanning QR codes.',
                      style: kTextStyle.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: AutoSizeText(
                      '-  Any user within the app can view public health information (following HIPAA protocol).',
                      style: kTextStyle.copyWith(
                          fontSize: 18.0, fontWeight: FontWeight.w400),
                      maxLines: 2,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: AutoSizeText(
                      '-  Medical professionals can access private health information.',
                      style: kTextStyle.copyWith(
                          fontSize: 18.0, fontWeight: FontWeight.w400),
                      maxLines: 2,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: AutoSizeText(
                      '-  Any user found misusing data or falsifying information will be penalized following the HIPAA policy',
                      style: kTextStyle.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 3,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'For more information, visit ',
                            style: kTextStyle.copyWith(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'HIPAA Policy',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                const url =
                                    "https://www.hhs.gov/hipaa/for-professionals/privacy/laws-regulations/index.html";
                                if (await canLaunchUrlString(url)) {
                                  await launchUrlString(url,
                                      mode: LaunchMode.inAppWebView);
                                } else {                               
                                  Toast.show(
                                    'Cannot launch browser',
                                    duration: Toast.lengthShort,
                                    gravity: Toast.bottom,
                                  );
                                }
                              },
                            style: kTextStyle.copyWith(
                              color: Colors.lightBlue,
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),
                      ),
                    ),
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
