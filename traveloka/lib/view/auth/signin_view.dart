import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:traveloka/view/home_view.dart';

import '../../components/button.dart';
import '../../components/hero_svg.dart';
import '../../components/input_box.dart';
import '../../config/ui_configs.dart';
import 'signup_view.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;
  bool _passwordVisible = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const HeroSvg(),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    EmailInputBox(
                      email: _email,
                      emailFocusNode: emailFocusNode,
                      passwordFocusNode: passwordFocusNode,
                    ),
                    const SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InputBox(
                          controller: _password,
                          focussed: () {},
                          onEditingComplete: () =>
                              FocusScope.of(context).unfocus(),
                          focusNode: passwordFocusNode,
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
                              const Text(''),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Forgot your password?',
                          style: UIConfig.indicationTextStyle
                              .copyWith(fontFamily: 'Nunito Sans'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Button(
                      function: () async {
                        try {
                          final userCred = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: _email.text,
                            password: _password.text,
                          );
                          print(userCred);
                          // await FirebaseAuth.instance.signOut();
                          // ignore: use_build_context_synchronously
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
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: UIConfig.textFieldInputTextStyle
                          .copyWith(fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                          CupertinoPageRoute(
                            builder: ((context) => const SignUpPage()),
                          ),
                          (route) => false),
                      child: Text(
                        'Sign up',
                        style: UIConfig.indicationTextStyle
                            .copyWith(fontFamily: 'Nunito Sans'),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
