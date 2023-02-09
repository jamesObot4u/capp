import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:layover/config/theme.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color beginColor;
  final Color endColor;
  final Color textColor;
  final Function()? onpressed;
  const CustomElevatedButton(
      {Key? key,
      required this.text,
      required this.beginColor,
      required this.endColor,
      required this.textColor,
      this.onpressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: theme().primaryColor.withAlpha(50),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(2, 2),
              ),
            ],
            gradient: LinearGradient(colors: [beginColor, endColor])),
        child: ElevatedButton(
          onPressed: onpressed,
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
              fixedSize: const Size(400, 40)),
          child: Container(
            width: double.infinity,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: theme().textTheme.headline4!.copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
