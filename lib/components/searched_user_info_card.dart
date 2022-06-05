import 'package:flutter/material.dart';
import 'package:medicalrecordapp/components/rounded_button.dart';
import 'package:medicalrecordapp/constants.dart';
import 'package:medicalrecordapp/models/blood_donor.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SearchedUserInfoCard extends StatelessWidget {
  final Donor searchedUser;

  SearchedUserInfoCard({this.searchedUser});

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
    if (this.searchedUser.name != '') {
      return Container(
        padding: EdgeInsets.all(24),
        margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                this.searchedUser.name,
                style: kTextStyle.copyWith(
                  fontSize: 24,
                  color: Colors.green[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Blood Group: ' + this.searchedUser.blood,
                style: kTextStyle.copyWith(
                  fontSize: 36,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Emergency Contact: ' + this.searchedUser.contact,
                style: kTextStyle.copyWith(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Location: ' + this.searchedUser.location,
                style: kTextStyle.copyWith(
                  fontSize: 18,
                ),
              ),
            ),
            RoundedButton(
                text: 'Call Emergency Number',
                color: Colors.green[900],
                onPressed: () {
                  callNumber(
                    context,
                    searchedUser.contact,
                  );
                }),
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
        child: Center(
          child: Text(
            'No User Found',
            style: kTextStyle.copyWith(
              color: Colors.black54,
              fontSize: 24,
            ),
          ),
        ),
      );
    }
  }
}
