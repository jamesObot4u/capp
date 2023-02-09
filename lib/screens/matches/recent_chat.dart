import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:layover/widgets/user_image_small.dart';

import '../../config/theme.dart';

class RecentChat extends StatefulWidget {
  const RecentChat(
      {Key? key,
      required this.name,
      required this.lasMessage,
      required this.image,
      required this.time,
      required this.id})
      : super(key: key);
  final String name;
  final String id;
  final String lasMessage;
  final String time;
  final String image;

  @override
  State<RecentChat> createState() => _RecentChatState();
}

class _RecentChatState extends State<RecentChat> {
  Future deleteData(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("messages")
          .doc(id)
          .delete();
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 9.0),
      child: Row(
        children: [
          UserImagesSmall(
            imageUrl: widget.image,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name,
                    style: theme().textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(243, 22, 21, 47))),
                const SizedBox(height: 2),
                SizedBox(
                  width: 220,
                  child: Text(widget.lasMessage,
                      overflow: TextOverflow.ellipsis,
                      style: theme().textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.normal,
                          color: const Color.fromARGB(243, 22, 21, 47))),
                ),
                const SizedBox(height: 5),
                Text(widget.time,
                    style: theme().textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: const Color.fromARGB(243, 22, 21, 47)))
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                deleteData(widget.id);
              },
              icon: Icon(
                Icons.delete,
                size: 20,
                color: theme().primaryColor,
              ))
        ],
      ),
    );
  }
}
