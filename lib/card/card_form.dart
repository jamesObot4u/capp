import 'package:flutter/material.dart';
import 'package:layover/config/theme.dart';

class CardForm extends StatelessWidget {
  const CardForm({Key? key}) : super(key: key);
  static const String routeName = '/card';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => CardForm(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay with Credit Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Card Form',
              style: theme().textTheme.headline5,
            ),
            // CardFormField(
            //   controller: CardFormEditController(),
            // )
          ],
        ),
      ),
    );
  }
}
