import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:traveloka/config/ui_configs.dart';
import 'view/auth/signin_view.dart';
import 'firebase_options.dart';
import 'view/home_view.dart';
// import 'view/auth/signup_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator.adaptive());
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
              // return const SignUpPage();
            }
          default:
            return const Center(child: CircularProgressIndicator.adaptive());
        }
      }),
    );
  }
}
