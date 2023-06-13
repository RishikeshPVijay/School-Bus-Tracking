import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_school_bus/app/app.router.dart';
import 'package:smart_school_bus/app/locator.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthenticationService {
  final NavigationService _navigationService = getIt<NavigationService>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  Future<bool> isUserLoggedIn() async {
    try {
      var user = _firebaseAuth.currentUser;
      return user != null;
    } catch (e) {
      throw 'Unknown error';
    }
  }

  User? getUser() {
    try {
      var user = _firebaseAuth.currentUser;
      return user;
    } catch (e) {
      throw 'Unknown error';
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream() {
    return _firestoreInstance
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .snapshots();
  }

  Future<UserCredential> login(String email, String password) async {
    try {
      return _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      var msg = 'An error occured, please check your credentials';

      if (e.message != null) {
        msg = e.message!;
      }
      throw msg;
    } catch (e) {
      throw 'Unknown error';
    }
  }

  Future<UserCredential> signup(String email, String password) async {
    try {
      return _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      var msg = 'An error occured, please check your credentials';

      if (e.message != null) {
        msg = e.message!;
      }
      throw msg;
    } catch (e) {
      throw 'Unknown error';
    }
  }

  Future<void> logout() async {
    _firebaseAuth.signOut();
    _navigationService.clearStackAndShow(Routes.loginView);
  }
}
