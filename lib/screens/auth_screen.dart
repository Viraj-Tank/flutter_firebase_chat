import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  void _submitAuthForm(String email, String username, String password, File? pickedImage, bool isLogin) async {
    try {
      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
          debugPrint('printlog login success');
        });
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) async {
          final ref = FirebaseStorage.instance.ref().child('user_image').child('${value.user!.uid}.jpg');

          await ref.putFile(pickedImage!).then((p0) async {
            final imageUrl = await p0.ref.getDownloadURL();
            saveUserInCollection(value, username, email,imageUrl);
          });
          debugPrint('printlog register success');
        });
      }
    } catch (error) {
      var message = 'wrong credentials';
      message = error.toString();
      debugPrint('printlog $message');
    }
  }

  saveUserInCollection(UserCredential credential, String userName, String email,String? imageUrl) async {
    await FirebaseFirestore.instance.collection('users').doc(credential.user?.uid).set({'username': userName, 'email': email,'image_url':imageUrl});
  }
}
