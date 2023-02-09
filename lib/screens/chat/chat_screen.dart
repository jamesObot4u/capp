// import 'dart:html';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';
import 'package:layover/screens/chat/single_message.dart';

import '../../blocs/profile/profile_bloc.dart';
import '../../model/user_model.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat';

  static Route route({required User user}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => ChatScreen(user: user),
    );
  }

  final User user;
  const ChatScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  bool hasMsg = true;
  @override
  Widget build(BuildContext context) {
    List<User> userss = [
      User(
          id: widget.user.id,
          name: widget.user.name,
          age: widget.user.age,
          status: widget.user.status,
          location: widget.user.location,
          likes: widget.user.likes,
          gender: widget.user.gender,
          imageUrls: widget.user.imageUrls,
          interest: widget.user.interest,
          bio: widget.user.bio,
          jobTitle: widget.user.jobTitle),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        toolbarHeight: 73,
        title: Column(
          children: [],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 168.0, top: 7),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/user', arguments: userss[0]);
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(widget.user.imageUrls[0]),
                  ),
                  Text(
                    widget.user.name,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is ProfileLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 85.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is ProfileLoaded) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(state.user.id)
                          .collection('messages')
                          .doc(widget.user.id)
                          .collection('chats')
                          .orderBy('date', descending: false)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.docs.length < 1) {
                            const Center(
                              child: Text('No conversation yet. Say \'Hi'),
                            );
                          } else {}

                          return ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (snapshot.data.docs.length > 0) {
                                } else {
                                  return Column(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(top: 40.0),
                                        child: Center(
                                          child: Text(
                                            'No conversation yet. Say \'Hi',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                bool isMe = snapshot.data.docs[index]
                                        ['senderId'] ==
                                    state.user.id;

                                return SingleMessage(
                                    messages: snapshot.data.docs[index]
                                        ['message'],
                                    isMe: isMe,
                                    image: widget.user.imageUrls[0],
                                    time: snapshot.data.docs[index]
                                        ['sent_time'],
                                    isImage: (snapshot.data.docs[index]
                                                ['type'] ==
                                            'image')
                                        ? true
                                        : false);
                              });
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20, top: 20, bottom: 20),
                  height: 90,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          final picker = ImagePicker();
                          PickedFile image;

                          //Check Permissions

                          //Select Image
                          final XFile? _image = await picker.pickImage(
                              source: ImageSource.gallery);
                          final firebase_storage.FirebaseStorage storage =
                              firebase_storage.FirebaseStorage.instance;
                          String imageUrl;
                          if (_image != null) {
                            //Upload to Firebase
                            var snapshot = await storage
                                .ref('${widget.user.id}/${_image.name}')
                                .putFile(
                                  File(_image.path),
                                );
                            var downloadUrl =
                                await snapshot.ref.getDownloadURL();
                            print(downloadUrl);
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(state.user.id)
                                .collection('messages')
                                .doc(widget.user.id)
                                .collection('chats')
                                .add({
                              "senderId": state.user.id,
                              "recieverId": widget.user.id,
                              "message": '${downloadUrl}',
                              'sent_time':
                                  DateFormat('jm').format(DateTime.now()),
                              "type": "image",
                              "date": DateTime.now()
                            }).then((value) {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(state.user.id)
                                  .collection('messages')
                                  .doc(widget.user.id)
                                  .set({
                                'last_msg': downloadUrl,
                                'type': 'image',
                                'id': widget.user.id,
                                'name': widget.user.name,
                                'location': widget.user.location,
                                'gender': widget.user.gender,
                                'age': widget.user.age,
                                'interest': widget.user.interest,
                                'bio': widget.user.bio,
                                'jobTitle': widget.user.jobTitle,
                                'likes': widget.user.likes,
                                'image': widget.user.imageUrls,
                                'sent_time':
                                    DateFormat('jm').format(DateTime.now()),
                              });
                              print('Done');
                              messageController.clear();
                            });
                          } else {
                            print('No Image Path Received');
                          }

                          print('clicked');

                          if (_image == null) {
                          } else {}
                        },
                        child: Icon(
                          Icons.camera_alt,
                          size: 30,
                          color: Color.fromARGB(255, 124, 122, 122),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          maxLines: null,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Type here...',
                            contentPadding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 5, top: 5),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.send_outlined),
                              onPressed: () async {
                                String message = messageController.text;
                                print(message);
                                if (message.isNotEmpty) {
                                  setState(() {
                                    hasMsg = false;
                                  });
                                  messageController.clear();
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(state.user.id)
                                      .collection('messages')
                                      .doc(widget.user.id)
                                      .collection('chats')
                                      .add({
                                    "senderId": state.user.id,
                                    "recieverId": widget.user.id,
                                    "message": message,
                                    'sent_time':
                                        DateFormat('jm').format(DateTime.now()),
                                    "type": "text",
                                    "date": DateTime.now()
                                  }).then((value) {
                                    messageController.clear();
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(state.user.id)
                                        .collection('messages')
                                        .doc(widget.user.id)
                                        .set({
                                      'last_msg': message,
                                      'id': widget.user.id,
                                      'name': widget.user.name,
                                      'location': widget.user.location,
                                      'gender': widget.user.gender,
                                      'interest': widget.user.interest,
                                      'age': widget.user.age,
                                      'bio': widget.user.bio,
                                      'jobTitle': widget.user.jobTitle,
                                      'likes': widget.user.likes,
                                      'type': 'text',
                                      'image': widget.user.imageUrls,
                                      'sent_time': DateFormat('jm')
                                          .format(DateTime.now()),
                                    });
                                    print('Done');
                                    messageController.clear();
                                  });

                                  //reciever side
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(widget.user.id)
                                      .collection('messages')
                                      .doc(state.user.id)
                                      .collection('chats')
                                      .add({
                                    "senderId": state.user.id,
                                    "recieverId": widget.user.id,
                                    "message": message,
                                    "type": "text",
                                    'sent_time':
                                        DateFormat('jm').format(DateTime.now()),
                                    "date": DateTime.now()
                                  }).then((value) {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(widget.user.id)
                                        .collection('messages')
                                        .doc(state.user.id)
                                        .set({
                                      'last_msg': message,
                                      'id': state.user.id,
                                      'name': state.user.name,
                                      'location': widget.user.location,
                                      'gender': widget.user.gender,
                                      'interest': widget.user.interest,
                                      'bio': widget.user.bio,
                                      'jobTitle': widget.user.jobTitle,
                                      'likes': widget.user.likes,
                                      'type': 'text',
                                      'image': state.user.imageUrls,
                                      'sent_time': DateFormat('jm')
                                          .format(DateTime.now()),
                                    });
                                    print('Done');
                                    messageController.clear();
                                  });
                                }
                              },
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return Text('');
        }
      }),
    );
  }
}
