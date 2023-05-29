import 'package:flutter/material.dart';
import 'package:insta_pay/sign_up.dart';
import 'components/text_field.dart';
import 'components/my_button.dart';
import 'dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void clearController() {
      _emailController.text = '';
      _passwordController.text = '';
    }

    Future signUserIn() async {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });

      try {
        final FirebaseAuth auth = FirebaseAuth.instance;
        await auth
            .signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text)
            .then((value) => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => Dashboard(id: value.user!.uid)),
                    ),
                  )
                });
        clearController();
      } on FirebaseAuthException catch (e) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: e.code);
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        children: [
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //logo
                const SizedBox(
                  height: 18,
                ),

                Container(
                    padding: const EdgeInsets.all(0),
                    height: 160.0,
                    width: 180.0,
                    child: Image.asset('assets/images/logo2.png')),

                //welcome back, you've been missed
                const SizedBox(
                  height: 10,
                ),

                Text(
                  'Welcome back, you\'ve been missed',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),

                const SizedBox(
                  height: 25.0,
                ),

                //username

                MyTextField(
                  fieldName: 'Username',
                  obscureText: false,
                  controller: _emailController,
                ),

                const SizedBox(
                  height: 15.0,
                ),

                //password
                MyTextField(
                  fieldName: 'Password',
                  obscureText: true,
                  controller: _passwordController,
                ),

                //sign in btn

                const SizedBox(
                  height: 25.0,
                ),

                MyButton(
                  onTap: signUserIn,
                  btnName: 'Sign In',
                ),

                const SizedBox(
                  height: 10,
                ),

                //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                const SizedBox(
                  height: 20,
                ),

                //not a member

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const SignUp()),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Not a member?'),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Register Now'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}