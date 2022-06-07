import 'package:flutter/material.dart';
import 'package:medicalrecordapp/constants.dart';


class CustomDropdownMenu extends StatefulWidget {
  final String label;
  List<String> items;
  String value;
  String initialValue;
  final Function onChanged;

  CustomDropdownMenu({Key key, 
    @required this.label,
    @required this.items,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    widget.value = widget.initialValue ?? widget.items.first;
    final dropdownMenuOptions = widget
        .items
        .map((String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontFamily: 'Nexa',
                  fontSize: 18,
                ),
              ),
            ))
        .toList();
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(6),
      child: DropdownButtonFormField(
        style: const TextStyle(
          fontFamily: 'Nexa',
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: widget.label,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          labelStyle: kTextStyle.copyWith(
            fontSize: 18,
            color: Colors.lightBlue[900],
          ),
        ),
        focusColor: Colors.lightBlue,
        value: widget.value,
        items: dropdownMenuOptions,
        onChanged: (newValue) {
          setState(() {
            widget.value = newValue;
          });

          setState(() {
            widget.onChanged(newValue);
          });
        },
      ),
    );
  }
}
