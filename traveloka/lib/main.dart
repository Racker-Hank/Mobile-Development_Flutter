import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:traveloka/config/UI_configs.dart';
import 'view/signin_view.dart';
import 'firebase_options.dart';
import 'view/booking_view.dart';
import 'view/explore_view.dart';
import 'view/profile_view.dart';
import 'view/saved_view.dart';
import 'view/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(MaterialApp(
    title: 'Traveloka',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: UIConfig.screenBackgroundColor,
      primarySwatch: Colors.blue,
    ),
    home: const Traveloka(),
  ));
}

class Traveloka extends StatelessWidget {
  const Traveloka({super.key});

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
              return const Home();
            } else {
              return const SignInPage();
            }
          default:
            return const Center(child: CircularProgressIndicator.adaptive());
        }
      }),
    );
    // return Home();
  }
}
