import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicalrecordapp/constants.dart';
import 'package:medicalrecordapp/models/blood_donor.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DonorInfoCard extends StatelessWidget {
  final Donor donor;

  DonorInfoCard({this.donor});

  callNumber(BuildContext context, String number) async {
    ToastContext().init(context);
    var url = 'tel:$number';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      Toast.show(
        'Cannot launch Phone',
        duration: Toast.lengthShort,
        gravity: Toast.bottom,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: this.donor.contact));
        Toast.show(
          'Contact number copied.',
          duration: Toast.lengthShort,
          gravity: Toast.bottom,
        );
      },
      child: Container(
        padding: EdgeInsets.all(24),
        margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    this.donor.blood,
                    style: kTextStyle.copyWith(
                      fontSize: 56,
                      color: Colors.green[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    this.donor.name,
                    style: kTextStyle.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    this.donor.contact,
                    style: kTextStyle.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    this.donor.location,
                    style: kTextStyle.copyWith(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {
                  callNumber(
                    context,
                    this.donor.contact,
                  );
                },
                icon: Icon(
                  Icons.phone,
                  size: 30,
                  color: Colors.green[900],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
