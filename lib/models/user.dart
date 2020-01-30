import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';


class User extends Equatable {
  User({this.displayName, this.uid, this.phone, this.email, this.photoUrl})
      : super();

   String displayName;
   String email;
   String phone;
   String uid;
   String photoUrl;

  

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
