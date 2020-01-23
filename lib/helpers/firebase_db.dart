import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_losses/models/item.dart';
import 'package:flutter_losses/models/user.dart';

class FirebaseService {
  final Firestore _db = Firestore.instance;

  //Get object list for the user
  Future<List<DocumentSnapshot>> getItems(User user) async {
    final QuerySnapshot result = await _db
        .collection('objects')
        .where('userId', isEqualTo: user.uid)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    return documents;
  }

  Future<List<DocumentSnapshot>> getUserProfile(String uid) async {
    final QuerySnapshot result = await _db
        .collection('users')
        .where('userId', isEqualTo: uid)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    return documents;
  }

  Future updateUserProfile(User user) async {
    _db.collection('users').document(user.uid).updateData({
         'displayName': user.displayName,
      'phone': user.phone,
      'email': user.email,
      'photoUrl': user.photoUrl,
   //   'userid': user.uid,
      'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),

    });
 }

   Future createUserInFirebase(FirebaseUser user) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('users')
        .where('userId', isEqualTo: user.uid)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    if (documents.length == 0) {
      // Update data to server if new user
      Firestore.instance.collection('users').document(user.uid).setData({
        'displayName': user.displayName,
        'phone': user.phoneNumber,
        'email': user.email,
        'photoUrl': user.photoUrl,
        'userId': user.uid,
        'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
      });
    }
  }

Future updateItem(Item item) async {
    _db.collection('objects').document(item.itemId).updateData({
      'objectId': item.itemId,
      'objectDescription': item.itemDescription,
      'objectName': item.itemName,
      'userId':item.userId,
      'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),

    });
 }

 Future createItem(Item item) async {
    _db.collection('objects').document(item.itemId).setData({
      'objectId': item.itemId,
      'objectDescription': item.itemDescription,
      'objectName': item.itemName,
      'userId':item.userId,
      'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),

    });
 }

}
