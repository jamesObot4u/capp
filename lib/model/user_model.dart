import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String name;
  final String gender;
  final String status;
  final String location;
  final int likes;
  final int age;
  final List<dynamic> imageUrls;
  final List<dynamic> interest;
  final String bio;
  final String jobTitle;

  const User(
      {required this.id,
      required this.name,
      required this.age,
      required this.status,
      required this.likes,
      required this.gender,
      required this.imageUrls,
      required this.interest,
      required this.location,
      required this.bio,
      required this.jobTitle});

  @override
  List<Object?> get props => [
        id,
        name,
        age,
        status,
        likes,
        gender,
        imageUrls,
        interest,
        bio,
        jobTitle
      ];

  factory User.fromSnapshot(DocumentSnapshot snap) {
    User user = User(
      id: snap['id'],
      name: snap['name'],
      age: snap['age'],
      status: snap['status'],
      location: snap['location'],
      likes: snap['likes'],
      imageUrls: snap['imageUrls'],
      interest: snap['interest'],
      gender: snap['gender'],
      bio: snap['bio'],
      jobTitle: snap['jobTitle'],
    );
    return user;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'status': status,
      'location': location,
      'likes': likes,
      'imageUrls': imageUrls,
      'interest': interest,
      'gender': gender,
      'bio': bio,
      'jobTitle': jobTitle,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? location,
    int? age,
    int? likes,
    List<dynamic>? imageUrls,
    List<dynamic>? interest,
    String? gender,
    String? bio,
    String? jobTitle,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      status: status ?? this.status,
      location: status ?? this.location,
      likes: likes ?? this.likes,
      gender: gender ?? this.gender,
      imageUrls: imageUrls ?? this.imageUrls,
      interest: imageUrls ?? this.interest,
      bio: bio ?? this.bio,
      jobTitle: jobTitle ?? this.jobTitle,
    );
  }

  static List<User> users = [];
}
