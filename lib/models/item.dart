import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Item extends Equatable {
  Item(
      {this.itemName,
      this.itemDescription,
      this.itemId,
      this.userId,
      this.showPhone,
      this.showEmail})
      : super();

  final String itemName;
  final String itemDescription;
  final String itemId;
  final String userId;
  bool showPhone;
  bool showEmail;

  @override
  List<Object> get props => [];

  factory Item.fromFirestore(DocumentSnapshot doc) {
    return Item(
        itemName: doc.data["objectName"] ?? "",
        itemDescription: doc.data["objectDescription"],
        itemId: doc.data["objectId"],
        userId: doc.data["userId"],
        showPhone: doc.data["showPhone"],
        showEmail: doc.data["showEmail"]);
  }
}
