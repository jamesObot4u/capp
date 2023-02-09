import 'package:flutter/material.dart';
import 'package:layover/config/theme.dart';
import 'package:layover/model/user_model.dart';
import 'package:layover/widgets/user_image_small.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.pushNamed(
          context,
          '/user',
          arguments: user,
        );
      }),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, top: 22.0),
        child: Stack(children: [
          Container(
            width: 110,
            height: 200,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(148, 203, 199, 199),
                      blurRadius: 2,
                      spreadRadius: 2,
                      offset: Offset(3, 3))
                ],
                border: const Border(
                    bottom: BorderSide(
                        color: Color.fromARGB(155, 9, 2, 53), width: 2),
                    top: BorderSide(
                        color: const Color.fromARGB(155, 9, 2, 53), width: 2),
                    right: BorderSide(
                        color: const Color.fromARGB(155, 9, 2, 53), width: 2),
                    left: BorderSide(
                        color: const Color.fromARGB(155, 9, 2, 53), width: 2))),
            child: Column(
              children: [
                Container(
                  width: 140,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage((user.imageUrls.length > 1)
                          ? user.imageUrls[0]
                          : 'https://storage.googleapis.com/proudcity/mebanenc/uploads/2021/03/placeholder-image-300x225.png'),
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: SizedBox(
                        width: 90,
                        child: Text(
                          user.name,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Color.fromARGB(255, 54, 48, 48)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              'Online',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      color: Color.fromARGB(255, 13, 12, 12),
                                      fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
