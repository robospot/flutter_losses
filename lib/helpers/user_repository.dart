import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_losses/helpers/firebase_db.dart';
import 'package:flutter_losses/models/user.dart';

import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    FirebaseService db = FirebaseService();
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    FirebaseUser user = await _firebaseAuth.currentUser();
    await db.createUserInFirebase(user);
    return _firebaseAuth.currentUser();
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp({String email, String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  String _verificationId;
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    FirebaseService db = FirebaseService();

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) {
      print("****Please check your phone for the verification code****");
      _verificationId = verificationId;
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print(
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    };
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) async {
      //  _firebaseAuth.signInWithCredential(phoneAuthCredential);
      FirebaseUser user =
          (await _firebaseAuth.signInWithCredential(phoneAuthCredential)).user;
      await db.createUserInFirebase(user);
//       _firebaseAuth
//           .signInWithCredential(phoneAuthCredential)
//           .then((AuthResult value) {

//         if (value.user != null) {
// await createUserInFirebase(user);
//           print('Auth success');
//         } else {
//           print('Auth error');
//         }
//       }).catchError((error) {
//         print('Auth error');
//       });

      print('Received phone auth credential: $phoneAuthCredential');
    };

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    print("${_firebaseAuth.currentUser()}");
  }

  Future<FirebaseUser> signInWithPhoneNumber(String smsCode) async {
    FirebaseService db = FirebaseService();
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: smsCode,
    );
    final FirebaseUser user =
        (await _firebaseAuth.signInWithCredential(credential)).user;
    final FirebaseUser currentUser = await _firebaseAuth.currentUser();

    assert(user.uid == currentUser.uid);
// Добавляем отправку данных в бекэнд

    await db.createUserInFirebase(user);
    // if (user != null) {
    //   print('Successfully signed in, uid: ' + user.uid);

    //   await createUserInFirebase(user);
    // } else {
    //   print('Sign in failed');
    // }
    return currentUser;
  }

  // Future createUserInFirebase(FirebaseUser user) async {
  //   final QuerySnapshot result = await Firestore.instance
  //       .collection('users')
  //       .where('userid', isEqualTo: user.uid)
  //       .getDocuments();
  //   final List<DocumentSnapshot> documents = result.documents;
  //   if (documents.length == 0) {
  //     // Update data to server if new user
  //     Firestore.instance.collection('users').document(user.uid).setData({
  //       'displayName': user.displayName,
  //       'phone': user.phoneNumber,
  //       'email': user.email,
  //       'photoUrl': user.photoUrl,
  //       'userid': user.uid,
  //       'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
  //     });
  //   }
  // }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<User> getUser() async {
    FirebaseService db = FirebaseService();
    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
    User currentUser =
          User.fromFirestore(await db.getUserProfile(firebaseUser.uid));
    return currentUser;
  }

  // addObject(ObjectData objectData) {
  //   var documentReference = Firestore.instance
  //       .collection('objects')
  //       // .document()
  //       // .collection('objects')
  //       .document(objectData.objectId);
  //   //.document(DateTime.now().millisecondsSinceEpoch.toString());

  //   Firestore.instance.runTransaction((transaction) async {
  //     await transaction.set(
  //       documentReference,
  //       {
  //         'objectid': objectData.objectId,
  //         'name': objectData.name,
  //         'description': objectData.description,
  //         'userid': objectData.userId
  //       },
  //     );
  //   });
  // }

  // Future<List<DocumentSnapshot>> listObjects(FirebaseUser user) async {
  //   final QuerySnapshot result = await Firestore.instance
  //       .collection('objects')
  //       .where('userid', isEqualTo: user.uid)
  //       .getDocuments();
  //   final List<DocumentSnapshot> documents = result.documents;
  //   return documents;
  // }
}
