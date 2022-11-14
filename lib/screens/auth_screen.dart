import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(submitFn: _submitAuthForm),
    );
  }

  void _submitAuthForm(String email, String username, String password, bool isLogin) async {
    try {
      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
          debugPrint('printlog login success');
        });
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
          saveUserInCollection(value,username,email);
          debugPrint('printlog register success');
        });
      }
    } catch (error) {
      var message = 'wrong credentials';
      message = error.toString();
      debugPrint('printlog $message');
    }
  }

  saveUserInCollection(UserCredential credential, String userName, String email) async {
    await FirebaseFirestore.instance.collection('users').doc(credential.user?.uid).set({'username': userName, 'email': email});
  }
}
