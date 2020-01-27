import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';


class User extends Equatable {
  User({this.displayName, this.uid, this.phone, this.email, this.photoUrl})
      : super();

  final String displayName;
  final String email;
  final String phone;
  final String uid;
  final String photoUrl;

  @override
  List<Object> get props => [];

  factory User.fromFirestore(List<DocumentSnapshot> doc) {
    return User(
        phone: doc.first.data["phone"] ?? "",
        email: doc.first.data["email"],
        displayName: doc.first.data["displayName"],
        photoUrl: doc.first.data["photoUrl"],
        uid: doc.first.data["userId"]);
  }
}
