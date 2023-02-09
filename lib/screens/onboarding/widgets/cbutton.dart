import 'package:flutter/material.dart';
import 'package:layover/config/theme.dart';

class Cbutton extends StatelessWidget {
  final TabController? tabController;
  final String text;
  void Function()? onpressed;
  Cbutton({
    Key? key,
    this.tabController,
    required this.text,
    this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
              colors: [theme().primaryColor, theme().secondaryHeaderColor])),
      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(elevation: 0, primary: Colors.transparent),
        onPressed: onpressed,
        child: SizedBox(
            width: double.infinity,
            child: Center(
                child: Text(
              text,
              style: theme().textTheme.headline4!.copyWith(color: Colors.white),
            ))),
      ),
    );
  }
}
