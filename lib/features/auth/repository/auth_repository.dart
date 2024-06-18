import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ai_shapers/core/constants/firebase_constants.dart';
import 'package:ai_shapers/core/providers/firebase_providers.dart';
import 'package:ai_shapers/models/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authRepositoryProvider = Provider(
  (ref) {
    return AuthRepository(
      firestore: ref.read(firebaseFirestoreProvider),
      firebaseAuth: ref.read(firebaseAuthProvider),
    );
  },
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth firebaseAuth,
  })  : _firestore = firestore,
        _firebaseAuth = firebaseAuth;

  Stream<User?> get authStageChange => _firebaseAuth.authStateChanges();

  //SIGN UP WITH EMAIL AND PASSWORD
  Future<Either<String, UserModel>> signUpWithEmailAndPassword(
      UserModel newUser) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: newUser.email,
        password: newUser.password!,
      );

      UserModel? user;
      String userUid = userCredential.user!.uid;
      newUser.uid = userUid;
      if (userCredential.additionalUserInfo!.isNewUser) {
        await _firestore.collection('users').doc(userUid).set(newUser.toMap());
        user = newUser;
      } else {
        user = await getUserData(userUid).first;
      }
      return right(user);
    } on FirebaseAuthException catch (e) {
      return left(e.message!);
    } catch (e) {
      return left(e.toString());
    }
  }

  //SIGN THE USER IN WITH EMAIL AND PASSWORD
  Future<Either<String, UserModel>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = await getUserData(userCredential.user!.uid).first;
      return right(user);
    } on FirebaseAuthException catch (e) {
      return left(e.message!);
    } catch (e) {
      return left(e.toString());
    }
  }

  //GET THE USER DATA
  Stream<UserModel> getUserData(String uid) {
    final snapshot = _user.doc(uid).snapshots();
    return snapshot.map(
      (event) {
        return UserModel(
          uid: event['uid'] as String? ?? '',
          name: event['name'] as String? ?? '',
          email: event['email'] as String? ?? '',
          password: event['password'] as String?,
          profileImage: event['profileImage'] as String? ?? '',
          createdAt: event['createdAt'] as Timestamp,
        );
      },
    );
  }

  //REFERENCE ALL THE USERS
  CollectionReference get _user =>
      _firestore.collection(FirebaseConstants.usersCollection);
}
