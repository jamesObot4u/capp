import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layover/blocs/profile/profile_bloc.dart';
import 'package:layover/blocs/swipe/swipe_bloc.dart';
import 'package:layover/config/theme.dart';
import 'package:layover/model/user_match_model.dart';
import 'package:layover/screens/matches/recent_chat.dart';
import 'package:layover/widgets/user_image_small.dart';

import '../../model/user_model.dart';
import '../../widgets/custom_appbar.dart';

class MatchesScreen extends StatefulWidget {
  static const String routeName = '/matches';

  const MatchesScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const MatchesScreen(),
    );
  }

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  @override
  Widget build(context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: 'Layover',
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          return BlocBuilder<SwipeBloc, SwipeState>(builder: (context, stated) {
            if (state is ProfileLoading || stated is SwipeLoading) {
              return const Padding(
                padding: EdgeInsets.only(top: 85.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (state is ProfileLoaded && stated is SwipeLoaded) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Recent Chats',
                        style: theme().textTheme.headline4!.copyWith(
                            color: const Color.fromARGB(205, 27, 21, 77)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(state.user.id)
                                    .collection('messages')
                                    .snapshots(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data.docs.length < 1) {
                                      const Center(
                                        child: Text(
                                            'No conversation yet. Say \'Hi'),
                                      );
                                    } else {
                                      return ListView.builder(
                                          itemCount: snapshot.data.docs.length,
                                          reverse: true,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            List<User> userss = [
                                              User(
                                                  id: snapshot.data.docs[index]
                                                      ['id'],
                                                  name: snapshot
                                                      .data.docs[index]['name'],
                                                  age: snapshot.data.docs[index]
                                                      ['age'],
                                                  status: 'Online',
                                                  location: snapshot.data
                                                      .docs[index]['location'],
                                                  likes: snapshot.data
                                                      .docs[index]['likes'],
                                                  gender: snapshot.data
                                                      .docs[index]['gender'],
                                                  imageUrls: [
                                                    snapshot.data.docs[index]
                                                        ['image'][index]
                                                  ],
                                                  interest: snapshot.data
                                                      .docs[index]['interest'],
                                                  bio: snapshot.data.docs[index]
                                                      ['bio'],
                                                  jobTitle: snapshot.data
                                                      .docs[index]['jobTitle']),
                                            ];
                                            return InkWell(
                                              onTap: (() {
                                                Navigator.pushNamed(
                                                    context, '/chat',
                                                    arguments: userss[0]);
                                              }),
                                              child: RecentChat(
                                                name: snapshot.data.docs[index]
                                                    ['name'],
                                                lasMessage: snapshot.data
                                                    .docs[index]['last_msg'],
                                                time: snapshot.data.docs[index]
                                                    ['sent_time'],
                                                image: snapshot.data.docs[index]
                                                    ['image'][0], id: snapshot.data.docs[index]
                                                    ['id'],
                                              ),
                                            );
                                          });
                                    }
                                  }
                                  ;
                                  return const Center(
                                    child: Text(''),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ]),
              );
            } else {
              return Text('');
            }
          });
        }));
  }
}
