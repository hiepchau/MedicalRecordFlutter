// ignore_for_file: no_leading_underscores_for_local_identifiers, library_private_types_in_public_api, prefer_const_declarations, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:medicalrecordapp/components/custom_dropdown_menu.dart';
import 'package:medicalrecordapp/components/custom_text_field.dart';
import 'package:medicalrecordapp/constants.dart';
import 'package:medicalrecordapp/models/diagnosis.dart';
import 'package:medicalrecordapp/services/EHR.dart';
import 'package:medicalrecordapp/services/authenticate.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AlertDialogForm extends StatefulWidget {
  final BuildContext context;

  const AlertDialogForm({Key key, @required this.context}) : super(key: key);

  @override
  _AlertDialogFormState createState() => _AlertDialogFormState();
}

class _AlertDialogFormState extends State<AlertDialogForm> {
  bool loadingIndicator = false;
  bool active = true;
  String type = '';
  TextEditingController problemController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final ehrDatabase = EHR(uid: Auth().getUID());

  Future<void> _submit() async {
    final _date = dateController.text;
    final _type = type;
    final _problem = problemController.text;
    final _verified = false;
    final _verifiedBy = "";

    Diagnosis _diagnosis = Diagnosis(
      date: _date,
      problem: _problem,
      type: _type,
      verified: _verified,
      verifiedBy: _verifiedBy,
    );
    await ehrDatabase.createDiagnosis(_diagnosis);
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.white,
      opacity: 0.9,
      progressIndicator: kWaveLoadingIndicator,
      inAsyncCall: loadingIndicator,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(6),
        title: Text(
          'New Diagnosis',
          style: kTextStyle.copyWith(
            fontSize: 24,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomDropdownMenu(
                label: 'Type',
                items: const [
                  'Disease',
                  'Accident',
                ],
                onChanged: (value) {
                  setState(() {
                    type = value;
                  });
                },
              ),
              CustomTextField(
                label: 'Description',
                hint: 'Diagnosed problem',
                controller: problemController,
                keyboardType: TextInputType.text,
              ),
              CustomTextField(
                label: 'Date',
                hint: 'MM, YYYY',
                controller: dateController,
                keyboardType: TextInputType.text,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              active = false;
              FocusScope.of(context).unfocus();
              setState(() {
                loadingIndicator = true;
              });
              await _submit();
              setState(() {
                loadingIndicator = false;
              });
              setState(() {});
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              'Submit',
              style: kTextStyle.copyWith(color: Colors.red, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
