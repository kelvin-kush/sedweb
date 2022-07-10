import 'package:sedweb/constraints.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final ButtonStyle style;
  final void Function() press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    required this.style,
    required this.text,
    required this.press,
    required this.color,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child:
            //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            // color: kPrimaryColor,
            ElevatedButton(
                onPressed: press,
                style: style,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: Text(
                    text,
                    style: TextStyle(color: textColor),
                  ),
                )),
      ),
    );
  }
}
