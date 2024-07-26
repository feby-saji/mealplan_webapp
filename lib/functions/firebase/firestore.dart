import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:web_app/models/family.dart';
import 'package:web_app/models/user.dart';

class FireStoreRepository {
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  CollectionReference familyCollection =
      FirebaseFirestore.instance.collection('family');

  Future<List<UserModel>> getAllusers() async {
    List<UserModel> users = [];
    try {
      final QuerySnapshot snapshot = await usersCollection.get();

      users = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return UserModel(
          email: data['email'] ?? '',
          familyId: data['familyId'] ?? '',
          uid: doc.id,
          name: data['username'] ?? '',
        );
      }).toList();
    } catch (e) {
      print('Error fetching users: $e');
    }
    return users;
  }

  Future<List<FamilyModel>> getAllFamilys() async {
    List<FamilyModel> familys = [];
    try {
      final QuerySnapshot snapshot = await familyCollection.get();
      familys = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return FamilyModel(
          id: data['familyId'] ?? '',
          createdOn: _formatTimestamp(data['createdOn']),
          creator: data['creator'] ?? '',
          members: List<String>.from(data['members'] ?? []),
        );
      }).toList();
    } catch (e) {
      print('Error fetching families: $e');
    }
    print('Printing families: $familys');
    return familys;
  }

  String _formatTimestamp(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();
    return '${dateTime.day}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year.toString().padLeft(2, '0')}';
  }

  Future<String> signUpUser(String name, String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Registration successful'; // Success message for UI handling
    } on FirebaseAuthException catch (e) {
      // Log the FirebaseAuthException code for debugging purposes
      print('FirebaseAuthException: ${e.code}');

      // Handle specific Firebase Authentication errors
      switch (e.code) {
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'email-already-in-use':
          return 'The account already exists for that email.';
        case 'invalid-email':
          return 'The email address is badly formatted.';
        case 'operation-not-allowed':
          return 'The operation is not allowed. Please enable the provider in Firebase Console.';
        case 'credential-already-in-use':
          return 'The credential is already associated with a different user account.';
        case 'user-disabled':
          return 'The user account has been disabled.';
        case 'user-not-found':
          return 'No user found for that email.';
        case 'wrong-password':
          return 'Wrong password provided for that user.';
        case 'too-many-requests':
          return 'We have blocked all requests from this device due to unusual activity. Try again later.';
        default:
          return 'An unexpected error occurred. Please try again later.';
      }
    } catch (e) {
      // Log any unexpected errors
      print('Unexpected error: $e');
      return 'An unexpected error occurred. Please try again later.';
    }
  }

  Future<String> logInUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Login successful';
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code}');

      switch (e.code) {
        case 'invalid-email':
          return 'The email address is badly formatted.';
        case 'user-disabled':
          return 'The user account has been disabled.';
        case 'user-not-found':
          return 'No user found for that email.';
        case 'wrong-password':
          return 'Wrong password provided for that user.';
        case 'email-already-in-use':
          return 'The email address is already in use by another account.';
        case 'operation-not-allowed':
          return 'The operation is not allowed. Please enable the provider in Firebase Console.';
        case 'weak-password':
          return 'The password is too weak.';
        case 'credential-already-in-use':
          return 'The credential is already associated with a different user account.';
        case 'too-many-requests':
          return 'We have blocked all requests from this device due to unusual activity. Try again later.';
        case 'expired-action-code':
          return 'The action code has expired.';
        case 'invalid-action-code':
          return 'The action code is invalid or malformed.';
        case 'invalid-credential':
          return 'The provided credentials are invalid. Please check the email and password.';
        default:
          return 'An unexpected error occurred. Please try again later.';
      }
    } catch (e) {
      // Log any unexpected errors
      print('Unexpected error: $e');
      return 'An unexpected error occurred. Please try again later.';
    }
  }

  bool checkUserExists() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print('logged out successfully');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
