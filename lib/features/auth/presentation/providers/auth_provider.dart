import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../data/auth_repository.dart';
import '../../data/user_model.dart';
import 'package:dartz/dartz.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  UserModel? _user;
  String? _errorText;

  UserModel? get user => _user;
  String? get errorText => _errorText;

  Future<void> signIn(String email, String password) async {

    final String? errorText = await _authRepository.signIn(email, password);
    if (errorText != null) {
      _errorText = errorText;
    } else {
      _errorText = null;
    }

    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    final String? errorText = await _authRepository.signUp(email, password);
    if (errorText != null) {
      _errorText = errorText;
    } else {
      _errorText = null;
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    final String? errorText = await _authRepository.signOut();
    if (errorText != null) {
      _errorText = errorText;
    } else {
      _errorText = null;
    }

    notifyListeners();
  }


  Future<void> resetPassword(String email) async {
    final String? errorText = await _authRepository.resetPassword(email);
    if (errorText != null) {
      _errorText = errorText;
    } else {
      _errorText = null;
    }

    notifyListeners();
  }


  Future<void> signInWithGoogle() async {
    print("Working 5");
    final String? errorText = await _authRepository.signInWithGoogle();
    if (errorText != null) {
      _errorText = errorText;
    } else {
      _errorText = null;
    }

    notifyListeners();
  }


  Future<void> signInWithPhoneNumber({required String phoneNumber,
    required Function() onVerificationCompletedUIFunction,
    required Function(String error) onVerificationFailedUIFunction,
    required Function() onCodeSentUIFunction,
    required Function() onCodeAutoRetrievalTimeoutUIFunction}) async {

    await _authRepository.signInWithPhoneNumber(phoneNumber: phoneNumber, onVerificationCompletedUIFunction: onVerificationCompletedUIFunction, onVerificationFailedUIFunction: onVerificationFailedUIFunction, onCodeSentUIFunction: onCodeSentUIFunction, onCodeAutoRetrievalTimeoutUIFunction: onCodeAutoRetrievalTimeoutUIFunction);
  }


  Future<void> signInWithFacebook() async {
    final String? errorText = await _authRepository.signInWithFacebook();
    if (errorText != null) {
      _errorText = errorText;
    } else {
      _errorText = null;
    }
  }

  void listenToAuthChanges() {
    _authRepository.authStateChange.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

}