import 'package:app_lma/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  LMAUser? lmaUser;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? u) {
      user = (u == null) ? null : u;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() async {
    user = _auth.currentUser;
    if (_auth.currentUser.toString() != 'null') {
      LMAUser newUser = LMAUser('', '', '', '', '', false, '', Timestamp(0, 0));
      FirebaseFirestore db = FirebaseFirestore.instance;
      await db
          .collection('users')
          .where('authId', isEqualTo: _auth.currentUser!.uid)
          .get()
          .then((event) {
        newUser = LMAUser.fromJson(event.docs[0].data());
      });
      lmaUser = newUser;
    } else {
      lmaUser = null;
    }
    notifyListeners();
  }

  register(String email, String password) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await newUser.user?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'week-password') {
        throw AuthException('Senha muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Email pertence a um usuário já existente.');
      } else {
        throw AuthException('Erro não mapeado: ${e.code}');
      }
    }
  }

  login(String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user.user!.emailVerified) {
        _getUser();
      } else {
        throw AuthException('Email não verificado.');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Usuário não encontrado.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta.');
      } else if (e.code == 'weak-password') {
        throw AuthException('Senha muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Email já possui uma conta vinculada.');
      } else {
        throw AuthException('Erro não mapeado: ${e.code}');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
