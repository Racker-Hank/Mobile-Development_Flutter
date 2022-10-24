import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';
import 'signin_view.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    // return const Text('Index 3: Profile');
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: ((context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text(snapshot.connectionState.toString());
          // case ConnectionState.waiting:
          //   // TODO: Handle this case.
          //   break;
          // case ConnectionState.active:
          //   // TODO: Handle this case.
          //   break;
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              // if (user.emailVerified) {
              //   return const Home();
              // } else {
              //   return const Text('not verified');
              // }
              print(user.photoURL);
              return Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 24,
                        child: user.photoURL != null
                            ? Image.network(user.photoURL!)
                            : Text(user.email![0]),
                      ),
                      const SizedBox(width: 8),
                      Text(user.email!),
                    ],
                  ),
                  TextButton(
                      child: Text('sign out'),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushAndRemoveUntil(
                            CupertinoPageRoute(
                              builder: ((context) => const SignInPage()),
                            ),
                            (route) => false);
                      })
                ],
              );
            } else {
              return const SignInPage();
            }
          default:
            return const Center(child: CircularProgressIndicator.adaptive());
        }
      }),
    );
  }
}
