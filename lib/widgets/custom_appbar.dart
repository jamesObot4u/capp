import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../config/theme.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool hasActions;
  const CustomAppBar({
    Key? key,
    required this.title,
    this.hasActions = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 220,
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.only(top: 18.0, bottom: 10),
        child: Row(
          children: [
            Expanded(
                child: SvgPicture.asset(
              'assets/images/logo.svg',
              height: 40.0,
              color: theme().primaryColor,
            )),
            Expanded(
              flex: 4,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: theme().primaryColor,
                    ),
              ),
            ),
          ],
        ),
      ),
      actions: hasActions
          ? [
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/matches');
                    },
                    // ignore: prefer_const_constructors
                    icon: Icon(
                      Icons.message_outlined,
                      color: theme().primaryColor,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 14),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    icon: Icon(Icons.person, color: theme().primaryColor)),
              )
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
