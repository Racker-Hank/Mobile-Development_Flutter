import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:traveloka/components/hero_svg.dart';
import 'package:traveloka/view/home_view.dart';

import '../components/button.dart';
import '../components/clip_path.dart';
import '../components/input_box.dart';
import '../config/ui_configs.dart';
import 'signin_view.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final TextEditingController _userName;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final FocusNode usernameFocusNode;
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;

  bool _passwordVisible = false;

  @override
  void initState() {
    _userName = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    usernameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _userName.dispose();
    _email.dispose();
    _password.dispose();
    usernameFocusNode.dispose();
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
                UsernameInputBox(
                    userName: _userName, emailFocusNode: emailFocusNode),
                const SizedBox(height: 24),
                EmailInputBox(
                    email: _email,
                    emailFocusNode: emailFocusNode,
                    passwordFocusNode: passwordFocusNode),
                const SizedBox(height: 24),
                passwordInputBox(context),
                const SizedBox(height: 24),
                Button(
                  function: () async {
                    try {
                      final userCred = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: _email.text,
                        password: _password.text,
                      );
                      // .then((cred) async =>
                      //     await cred.user?.updateDisplayName('test'));
                      userCred.user?.updateDisplayName(_userName.text);
                      await userCred.user?.reload();
                      print(FirebaseAuth.instance.currentUser);
                      // await userCred.user?.updatre
                      // print(userCred);
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
                  label: 'Sign Up',
                  icon: Icon(
                    Icons.travel_explore_rounded,
                    color: UIConfig.white,
                  ),
                  showIcon: true,
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member?',
                      style: UIConfig.textFieldInputTextStyle
                          .copyWith(fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                          CupertinoPageRoute(
                            builder: ((context) => const SignInPage()),
                          ),
                          (route) => false),
                      child: Text(
                        'Sign in',
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

  InputBox passwordInputBox(BuildContext context) {
    return InputBox(
      controller: _password,
      focussed: () {},
      onEditingComplete: () => FocusScope.of(context).unfocus(),
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
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
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
    );
  }
}

class UsernameInputBox extends StatelessWidget {
  const UsernameInputBox({
    Key? key,
    required TextEditingController userName,
    required this.emailFocusNode,
  })  : _userName = userName,
        super(key: key);

  final TextEditingController _userName;
  final FocusNode emailFocusNode;

  @override
  Widget build(BuildContext context) {
    return InputBox(
      controller: _userName,
      focussed: () {},
      onEditingComplete: () => emailFocusNode.requestFocus(),
      hintText: '',
      labelText: 'Username',
      autoCorrect: false,
      prefixIcon: Icon(
        Icons.person_rounded,
        color: UIConfig.black,
        size: 20,
      ),
    );
  }
}

class EmailInputBox extends StatelessWidget {
  const EmailInputBox({
    Key? key,
    required TextEditingController email,
    required this.emailFocusNode,
    required this.passwordFocusNode,
  })  : _email = email,
        super(key: key);

  final TextEditingController _email;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    return InputBox(
      controller: _email,
      focussed: () {},
      focusNode: emailFocusNode,
      onEditingComplete: () => passwordFocusNode.requestFocus(),
      hintText: '',
      labelText: 'Email',
      autoCorrect: false,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icon(
        Icons.email_rounded,
        color: UIConfig.black,
        size: 20,
      ),
    );
  }
}
