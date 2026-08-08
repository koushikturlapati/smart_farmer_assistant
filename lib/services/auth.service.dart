
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;


  // Google Login

  Future<User?> signInWithGoogle() async {

    try {

      final GoogleSignInAccount? googleUser =
      await GoogleSignIn().signIn();


      if (googleUser == null) {
        return null;
      }


      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;


      final credential =
      GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );


      UserCredential result =
      await _auth.signInWithCredential(credential);


      User? user = result.user;


      if(user != null){

        await _firestore
            .collection("users")
            .doc(user.uid)
            .set({

          "uid": user.uid,
          "name": user.displayName,
          "email": user.email,
          "photo": user.photoURL,
          "loginType": "google",
          "createdAt": Timestamp.now(),

        }, SetOptions(merge: true));

      }


      return user;


    } catch(e){

      print("Google Login Error: $e");

      return null;

    }

  }

}