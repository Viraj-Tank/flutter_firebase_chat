import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase/widgets/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  AuthForm({
    Key? key,
    required this.submitFn,
  }) : super(key: key);

  final void Function(String email, String userName, String password,File? image, bool isLogin) submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String? _userEmail = '';
  String? _userName = '';
  String? _userPassword = '';
  File? _userImageFile;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) UserImagePicker(imagePickFn: _pickedImage),
                  TextFormField(
                    key: const ValueKey('email'),

                    ///used to differentiate all textform fields so data dont lose its integrity
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value?.isEmpty == true && !value!.contains('@')) {
                        return 'Please enter proper email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('uName'),
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return 'enter user name';
                        } else if (value!.length < 4) {
                          return 'enter at least 4 character in user name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value?.isEmpty == true && value!.length < 7) {
                        return 'please enter at least 7 character password';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userPassword = value;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text(_isLogin ? 'Login' : 'Sign Up'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin ? 'Create New Account' : 'Already have an account?'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _trySubmit() {
    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please pick an image')),
      );
      return;
    }
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState?.save(); // it will trigger onSaved method on every textFormField available in the _formKey

      FocusScope.of(context).unfocus(); //remove the focus from textFields if any
      widget.submitFn(
        _userEmail!,
        _userName!,
        _userPassword!,
        _userImageFile,
        _isLogin,
      );
    }
  }

  void _pickedImage(File image) {
    _userImageFile = image;
  }
}
