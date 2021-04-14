import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    this.color,
    this.text,
    this.textColor: Colors.white,
    this.onPress,
    Key key,
  }) : super(key: key);

  final Color color;
  final Color textColor;
  final String text;
  final onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
          onPressed: onPress,
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
          ),
          style: ElevatedButton.styleFrom(
              primary: color,
              elevation: 3.0,
              padding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              shadowColor: color)),
    );
  }
}
