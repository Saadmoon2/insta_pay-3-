import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'components/text_field.dart';
import 'components/my_button.dart';
import 'components/circle_image_picker.dart';
import 'components/password_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String imageURL = 'NULL';

  void imageURLUpdated(String url) {
    imageURL = url;
  }

  void clearController() {
    _nameController.text = '';
    _emailController.text = '';
    _passwordController.text = '';
  }

  void signUp(String name, String email, String password, String imageURL) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    Map<String, dynamic> userData = {
      'Name': name,
      'imageURL': imageURL,
      'Email': _emailController.text
    };

    Map<String, dynamic> walletData = {
      'userID': '', 
    };

    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        final userReference =
            FirebaseFirestore.instance.collection('users').doc(value.user?.uid);
        userReference.set(userData);

        final walletReference =
            FirebaseFirestore.instance.collection('wallet').doc(value.user?.uid);
        walletData['userID'] = value.user?.uid;
        walletReference.set(walletData);
      });
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: 'Account Created');
      clearController();
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue[800],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: (() {
                      Navigator.of(context).pop();
                    }),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Text(
                    'Create Account',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          CircleImagePicker(
            callback: imageURLUpdated,
          ),
          const SizedBox(
            height: 20.0,
          ),
          MyTextField(
            fieldName: 'Name',
            controller: _nameController,
            obscureText: false,
          ),
          const SizedBox(
            height: 5.0,
          ),
          MyTextField(
            fieldName: 'Email',
            controller: _emailController,
            obscureText: false,
          ),
          const SizedBox(
            height: 5.0,
          ),
          PasswordTextField(
            fieldName: 'Password',
            controller: _passwordController,
            obscureText: true,
          ),
          const SizedBox(
            height: 10.0,
          ),
          MyButton(
            onTap: () {
              signUp(
                _nameController.text,
                _emailController.text,
                _passwordController.text,
                imageURL,
              );
            },
            btnName: 'Create',
          ),
          const SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
  }
}
