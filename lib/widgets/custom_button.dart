import 'package:flutter/material.dart';

import '../config/theme.dart';

class ChoiceButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double size;
  final bool hasGradient;
  final IconData icon;
  final Function()? onpressed;

  const ChoiceButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.color,
      required this.icon,
      required this.hasGradient,
      required this.size,
      this.onpressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          gradient: hasGradient
              ? LinearGradient(
                  colors: [theme().primaryColor, theme().secondaryHeaderColor],
                )
              : const LinearGradient(colors: [Colors.white, Colors.white]),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 118, 115, 115).withAlpha(50),
                spreadRadius: 4,
                blurRadius: 4,
                offset: const Offset(3, 3))
          ]),
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }
}
