import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:layover/config/theme.dart';

class CustomImageContainer extends StatelessWidget {
  final TabController tabController;
  const CustomImageContainer({Key? key, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, bottom: 10.0, right: 10.0),
      child: Column(
        children: [
          Container(
            height: 150,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border(
                  bottom: BorderSide(color: theme().primaryColor, width: 1),
                  top: BorderSide(color: theme().primaryColor, width: 1),
                  right: BorderSide(color: theme().primaryColor, width: 1),
                  left: BorderSide(color: theme().primaryColor, width: 1)),
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(Icons.add_circle),
                color: theme().secondaryHeaderColor,
                onPressed: () async {
                  print('clicked');
                  ImagePicker picker = ImagePicker();
                  final XFile? _image =
                      await picker.pickImage(source: ImageSource.gallery);
                  final XFile? _photo =
                      await picker.pickImage(source: ImageSource.camera);

                  if (_image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('No image was selected.')));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Image upload sucesful')));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
