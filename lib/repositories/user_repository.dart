
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepos extends StatefulWidget {
  static String routeName = "userrepos";
  @override
  _UserRepos createState() => _UserRepos();
}

class _UserRepos extends State<UserRepos> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Login with Firebase',
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}

class UserRepository {
  final FirebaseAuth? _firebaseAuth;
  final GoogleSignIn? _googleSignIn;
  //constructor

  UserRepository({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<User?> signInWithGoogle() async {
//    await _googleSignIn.signIn();
//    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
//    return firebaseUser;
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn!.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.accessToken,
        accessToken: googleSignInAuthentication?.idToken);
    await _firebaseAuth!.signInWithCredential(authCredential);
    final currentUser = _firebaseAuth!.currentUser;
    return currentUser;
  }

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    return await _firebaseAuth!
        .signInWithEmailAndPassword(email: email.trim(), password: password);
  }

  Future<UserCredential?> createUserWithEmailAndPassword(String email, String password) async {
      try{
        var create = await _firebaseAuth!.createUserWithEmailAndPassword(
            email: email.trim(), password: password);
        return  create;
      }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Future<List<void>>> signOut() async {
    return Future.wait([_firebaseAuth!.signOut(), _googleSignIn!.signOut()]);
  }

  Future<bool> isSignedIn( String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return false;
    }
  }

  Future<User?> getUser() async {
    return _firebaseAuth!.currentUser;
  }

}
