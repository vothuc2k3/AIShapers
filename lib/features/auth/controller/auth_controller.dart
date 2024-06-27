import 'dart:async';

import 'package:ai_shapers/core/constants/constants.dart';
import 'package:ai_shapers/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ai_shapers/features/auth/repository/auth_repository.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.read(authRepositoryProvider),
    ref: ref,
  ),
);

final authStageChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStageChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStageChange => _authRepository.authStageChange;

  //SIGN UP WITH EMAIL AND PASSWORD
  Future<Either<String, UserModel>> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    state = true;
    try {
      UserModel userModel = UserModel(
        email: email,
        password: password,
        name: email,
        uid: '',
        profileImage: Constants.avatarDefault,
        createdAt: Timestamp.now(),
      );
      final result =
          await _authRepository.signUpWithEmailAndPassword(userModel);
      return result.fold((l) => left(l.toString()), (userModel) {
        _ref.read(userProvider.notifier).update((state) => userModel);
        return right(userModel);
      });
    } on FirebaseAuthException catch (e) {
      return left(e.message!);
    } catch (e) {
      return left(e.toString());
    } finally {
      state = false;
    }
  }

  //SIGN IN WITH EMAIL AND PASSWORD
  Future<Either<String, UserModel>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    state = true;
    try {
      final result =
          await _authRepository.signInWithEmailAndPassword(email, password);
      return result.fold((l) {
        return left(l);
      }, (userModel) {
        _ref.read(userProvider.notifier).update((state) => userModel);
        return right(userModel);
      });
    } on FirebaseAuthException catch (e) {
      return left(e.message!);
    } catch (e) {
      return left(e.toString());
    } finally {
      state = false;
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  //SIGN THE CURRENT OUT
  void signOut(WidgetRef ref)async {
    _authRepository.signOut(ref);
  }
}
