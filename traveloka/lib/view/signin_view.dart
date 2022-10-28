import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:traveloka/view/home_view.dart';

import '../components/button.dart';
import '../components/input_box.dart';
import '../config/ui_configs.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _passwordVisible = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputBox(
                controller: _email,
                focussed: () {},
                hintText: '',
                labelText: 'Email',
                autoCorrect: false,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Icons.email_rounded,
                  color: UIConfig.black,
                  size: 20,
                ),
              ),
              const SizedBox(height: 24),
              InputBox(
                controller: _password,
                focussed: () {},
                hintText: '',
                labelText: 'Password',
                autoCorrect: false,
                obscureText: !_passwordVisible,
                prefixIcon: Icon(
                  Icons.vpn_key_rounded,
                  color: UIConfig.black,
                  size: 20,
                ),
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: UIConfig.primaryColor,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                    Text(''),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Button(
                function: () async {
                  try {
                    final userCred =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _email.text,
                      password: _password.text,
                    );
                    print(userCred);
                    // await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(
                          builder: ((context) => const Home()),
                        ),
                        (route) => false);
                  } on Exception catch (e) {
                    print(e);
                  }
                },
                label: 'Sign In',
                icon: Icon(
                  Icons.flight_takeoff_rounded,
                  color: UIConfig.white,
                ),
                showIcon: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
