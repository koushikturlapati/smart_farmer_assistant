import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
class AuthService {


  final FirebaseAuth _auth =
      FirebaseAuth.instance;


  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;
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

        accessToken:
        googleAuth.accessToken,

        idToken:
        googleAuth.idToken,

      );

      UserCredential result =
      await _auth.signInWithCredential(
        credential,
      );

      User? user = result.user;
      if(user != null){


        await _firestore
            .collection("users")
            .doc(user.uid)
            .set({


          "uid": user.uid,

          "name": user.displayName ?? "",

          "email": user.email ?? "",

          "photo": user.photoURL ?? "",

          "loginType": "google",

          "createdAt": Timestamp.now(),


        }, SetOptions(merge:true));


      }
      print("Login Success: ${user?.email}");


      return user;



    } catch(e, stackTrace){


      debugPrint(
          "Google Login Error : $e"
      );


      debugPrint(stackTrace.toString());


      throw e;


    }

  }

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(String verificationId) codeSent,
    required Function(User user) onSuccess,
    required Function(String error) onError,
  }) async {

    await _auth.verifyPhoneNumber(

      phoneNumber: phoneNumber,

      verificationCompleted:
          (PhoneAuthCredential credential) async {

        UserCredential result =
        await _auth.signInWithCredential(credential);


        if(result.user != null){

          await saveUser(
              result.user!,
              "phone"
          );

          onSuccess(result.user!);

        }

      },


      verificationFailed:
          (FirebaseAuthException e){

        onError(
            e.message ?? "Verification failed"
        );

      },


      codeSent:
          (String verificationId, int? resendToken){

        codeSent(verificationId);

      },


      codeAutoRetrievalTimeout:
          (String verificationId){},

    );

  }



  Future<void> verifyOTP({
    required String verificationId,
    required String otp,
    required Function(User user) onSuccess,
  }) async {


    PhoneAuthCredential credential =
    PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );


    UserCredential result =
    await _auth.signInWithCredential(
        credential
    );


    if(result.user != null){

      await saveUser(
          result.user!,
          "phone"
      );

      onSuccess(result.user!);

    }

  }



  Future<void> saveUser(
      User user,
      String loginType
      ) async {


    await _firestore
        .collection("users")
        .doc(user.uid)
        .set({

      "uid": user.uid,

      "phone": user.phoneNumber ?? "",

      "email": user.email ?? "",

      "name": user.displayName ?? "",

      "loginType": loginType,

      "createdAt": Timestamp.now(),
    },
        SetOptions(merge:true));
  }
  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();


  }



}