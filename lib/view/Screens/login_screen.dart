import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:study_hub/utils/constants/colors.dart';

final _firebase = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _islogin = true;
  String _enterdEmail = '';
  String _enterdUsername = '';
  String _enterdPasswoud = '';
  bool _isUploading = false;

  void _supmit() async {
    bool vaild = _formKey.currentState!.validate();
    if (!vaild) {
      // log("dEmail");
      return;
    }
    try {
      // log("_enterdEmail");
      setState(() {
        _isUploading = true;
      });
      if (_islogin) {
        // final UserCredential userCredential =
        await _firebase.signInWithEmailAndPassword(
          email: _enterdEmail,
          password: _enterdPasswoud,
        );
      } else {
        //log(_enterdEmail);

        await _firebase.createUserWithEmailAndPassword(
          email: _enterdEmail,
          password: _enterdPasswoud,
        );

        //log(_enterdEmail);
        // log(_enterdPasswoud);
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Authentication faild.'),
        ),
      );
      setState(() {
        _isUploading = false;
      });
    }
    _formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 30,
                ),
                width: 200,
                child: Image.asset('assets/images/login.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          if (!_islogin)
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.trim().length < 4) {
                                  return 'Please enter at least 4 character';
                                }
                                return null;
                              },
                              onSaved: (newValue) =>
                                  _enterdUsername = newValue!,
                              decoration: InputDecoration(
                                label: Text(
                                  'Username',
                                  style: GoogleFonts.alef(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email adderss';
                              }
                              return null;
                            },
                            onSaved: (newValue) => _enterdEmail = newValue!,
                            decoration: InputDecoration(
                              label: Text(
                                'Email',
                                style: GoogleFonts.alef(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Password can\'t be less than 6 character';
                              }
                              return null;
                            },
                            onSaved: (newValue) => _enterdPasswoud = newValue!,
                            decoration: InputDecoration(
                              label: Text(
                                'Password',
                                style: GoogleFonts.alef(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (_isUploading) const CircularProgressIndicator(),
                          if (!_isUploading)
                            ElevatedButton(
                              onPressed: _supmit,
                              style: TextButton.styleFrom(
                                  backgroundColor: MyColors.primary,
                                  fixedSize: Size(120, 60)),
                              child: Text(
                                _islogin ? 'Login' : 'Sign Up',
                                style: GoogleFonts.alef(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 12,
                          ),
                          if (!_isUploading)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_islogin)
                                  Text(
                                    'don`t have an account?',
                                    style: GoogleFonts.alef(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _islogin = !_islogin;
                                    });
                                  },
                                  child: Text(
                                    _islogin
                                        ? 'register'
                                        : 'I allredy have an account',
                                    style: GoogleFonts.alef(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
