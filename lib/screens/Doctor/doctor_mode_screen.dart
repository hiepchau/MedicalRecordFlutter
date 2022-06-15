// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:medicalrecordapp/components/custom_text_field.dart';
import 'package:medicalrecordapp/components/rounded_button.dart';
import 'package:medicalrecordapp/constants.dart';
import 'package:medicalrecordapp/screens/Doctor/doctor_dashboard_screen.dart';
import 'package:medicalrecordapp/services/authenticate.dart';
import 'package:medicalrecordapp/services/database.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class DoctorModeScreen extends StatefulWidget {
  static String id = 'doctor_mode';

  const DoctorModeScreen({Key key}) : super(key: key);

  @override
  _DoctorModeScreenState createState() => _DoctorModeScreenState();
}

class _DoctorModeScreenState extends State<DoctorModeScreen> {
  final database = Database(uid: Auth().getUID());
  bool loadingIndicator = false;
  String verify = '';
  TextEditingController doctorIdController = TextEditingController();

  Future<void> verifyDoctor(String id) async {
    final _verify = await database.verifyDoctor(id);
    setState(() {
      verify = _verify;
    });
  }

  Future<bool> addDoctor(String id) async {
    return await database.addDoctor(id);
  }

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
      appBar: AppBar(
        leadingWidth: 0,
        title: Row(
          children: [
            Hero(
              tag: 'logo',
              child: SizedBox(
                height: 40.0,
                child: Image.asset(
                  'assets/images/medical_logo.png',
                ),
              ),
            ),
            const Text(
              'Doctor Mode',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Nexa Bold',
                fontSize: 24,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.black54,
      ),
      body: ModalProgressHUD(
        color: Colors.white,
        opacity: 0.9,
        progressIndicator: kWaveLoadingIndicator,
        inAsyncCall: loadingIndicator,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text(
                  'Verify yourself with your',
                  style: kTextStyle.copyWith(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'BMDC registration number',
                  style: kTextStyle.copyWith(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                label: 'Doctor Registration Number',
                hint: 'BMDC Registration Number',
                controller: doctorIdController,
                keyboardType: TextInputType.number,
              ),
              RoundedButton(
                text: 'Verify',
                color: Colors.lightBlue[700],
                onPressed: () async {
                  if (doctorIdController.text == '') {
                    showMessage('You did not type anything!');
                  } else {
                    setState(() {
                      loadingIndicator = true;
                    });
                    await verifyDoctor(doctorIdController.text);
                    if (verify == 'Success') {
                      showMessage(verify);
                      Navigator.pushNamed(context, DoctorDashboardScreen.id);
                    } else if (verify == 'Doctor is not existed') {
                      showMessage(verify);
                    } else {
                      showMessage(verify);
                    }
                    setState(() {
                      loadingIndicator = false;
                    });
                  }
                },
              ),
              RoundedButton(
                text: 'Add Doctor',
                color: Colors.lightBlue[700],
                onPressed: () async {
                  if (doctorIdController.text == '') {
                    showMessage('You did not type anything!');
                  } else {
                    setState(() {
                      loadingIndicator = true;
                    });
                    if (await addDoctor(doctorIdController.text) == true) {
                      Navigator.pushNamed(context, DoctorDashboardScreen.id);
                    } else {
                      showMessage('This doctor has existed!');
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
    );
  }
}
