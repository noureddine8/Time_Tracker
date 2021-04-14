import 'package:flutter/material.dart';

import 'customButton.dart';

class AuthButton extends CustomButton {
  final String image;
  final Color borderColor;

  AuthButton({this.image, this.borderColor, color, text, textColor})
      : super(color: color, text: text, textColor: textColor);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(image),
            Text(
              text,
              style: TextStyle(
                  color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Opacity(
              opacity: 0,
              child: Image.asset("images/google-logo.png"),
            )
          ],
        ),
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: borderColor, width: 0.5),
            padding: EdgeInsets.all(15),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))),
      ),
    );
  }
}
