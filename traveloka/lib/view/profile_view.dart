import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:traveloka/config/UI_configs.dart';

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
              String displayName = user.displayName ?? user.email!;
              // print(user.photoURL);
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(left: 16, right: 16, top: 32),
                        height: 80,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            borderRadius: UIConfig.borderRadius,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(30, 0, 0, 0),
                                offset: Offset(0, 1),
                                blurRadius: 3,
                                spreadRadius: 1,
                              ),
                              BoxShadow(
                                color: Color.fromARGB(50, 0, 0, 0),
                                offset: Offset(0, 1),
                                blurRadius: 2,
                                spreadRadius: 0,
                              )
                            ],
                            color: UIConfig.white),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: CircleAvatar(
                                maxRadius: 24,
                                child: user.photoURL != null
                                    ? Image.network(user.photoURL!)
                                    : Text(UIConfig.capitalize(displayName[0])),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    //user.displayName!,
                                    // user.uid!,
                                    displayName,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      // fontWeight: FontWeight.normal,
                                      fontSize: 22,
                                      fontFamily: 'Roboto',
                                      color: UIConfig.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Icon(Icons.border_color_rounded),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      const SettingTile(
                          tileName: 'My Wallet',
                          tileText: 'View and set preferences',
                          tileIcon: Icon(Icons.account_balance_wallet)),
                      const SizedBox(height: 32),
                      const SettingTile(
                          tileName: 'Settings',
                          tileText: 'View and set preferences',
                          tileIcon: Icon(Icons.settings)),
                      const SizedBox(height: 8),
                      const SettingTile(
                          tileName: 'Help Center',
                          tileText: 'FAQs',
                          tileIcon: Icon(Icons.help))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: GestureDetector(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushAndRemoveUntil(
                            CupertinoPageRoute(
                              builder: ((context) => const SignInPage()),
                            ),
                            (route) => false);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDC362E),
                          borderRadius: UIConfig.borderRadius,
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(70, 0, 0, 0),
                                offset: Offset(0, 2),
                                blurRadius: 3),
                            BoxShadow(
                                color: Color.fromARGB(30, 0, 0, 0),
                                offset: Offset(0, 6),
                                blurRadius: 10,
                                spreadRadius: 4)
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sign out 🎉',
                              style: UIConfig.buttonTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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

class SettingTile extends StatelessWidget {
  const SettingTile(
      {super.key,
      required this.tileName,
      required this.tileText,
      required this.tileIcon});

  final String tileName;

  final String tileText;

  final Icon tileIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        height: 80,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
            borderRadius: UIConfig.borderRadius,
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(30, 0, 0, 0),
                  offset: Offset(0, 1),
                  blurRadius: 3,
                  spreadRadius: 1),
              BoxShadow(
                  color: Color.fromARGB(50, 0, 0, 0),
                  offset: Offset(0, 1),
                  blurRadius: 2,
                  spreadRadius: 0)
            ],
            color: UIConfig.white),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 19),
              child: tileIcon,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tileName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Roboto'),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tileText,
                    style: const TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                  )
                ],
              ),
            ),
            const SizedBox(width: 16),
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.keyboard_arrow_right_rounded),
            )
          ],
        ),
      ),
    );
  }
}
