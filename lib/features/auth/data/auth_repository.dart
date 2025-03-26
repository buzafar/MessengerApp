import 'user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch(e) {
      return "email or password is incorrect";
    } catch (e) {
      return "Something went wrong";
    }
  }

  Future<String?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return "The email is already in use";
      } else {
        return "Something went wrong";
      }
    } catch (e) {
      return "Something went wrong";
    }
  }

  Future<String?> signOut() async {
    try {
      await _auth.signOut();
      return null;
    } catch (e) {
      return "Something went wrong";
    }
  }
  // It does not throw errors, gotta fix
  Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } catch (e) {
      print("Something went wrong");
      return "Something went wrong";
    }
  }


  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      
      if (googleUser == null) {
        return "Canceled";
      }
      
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken
      );
      
      await _auth.signInWithCredential(credential);
      return null;
    } on FirebaseAuthException catch (e) {
      return "Something went wrong";
    } catch (e) {
      return "Semething went wrong";
    }
  }


  Future<void> signInWithPhoneNumber({required String phoneNumber,
      required Function() onVerificationCompletedUIFunction,
      required Function(String error) onVerificationFailedUIFunction,
      required Function() onCodeSentUIFunction,
      required Function() onCodeAutoRetrievalTimeoutUIFunction}) async {

    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,

        verificationCompleted: (PhoneAuthCredential credential) async {
          onVerificationCompletedUIFunction();
          await _auth.signInWithCredential(credential);
        },

        verificationFailed: (FirebaseAuthException e) {
          onVerificationFailedUIFunction("${e.message}, ${e.code}");
          print(e.code);
          print(e.message);
        },

        codeSent: (String verificationID, int? resendToken) {
          onCodeSentUIFunction();
          print("The code has been sent");
        },

        codeAutoRetrievalTimeout: (String verificationID) {
          onCodeAutoRetrievalTimeoutUIFunction();

        }
    );
  }

  Future<String?> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      await _auth.signInWithCredential(facebookAuthCredential);
      return null;
    } catch (error) {
      return "${error}";
    }
  }



  Stream<UserModel?> get authStateChange {
    return _auth.authStateChanges().map((user) => user != null ? UserModel(uid: user.uid, email: user.email!): null);
  }
}