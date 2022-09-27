import 'package:flutter/material.dart';

class MyExplorePage extends StatefulWidget {
  const MyExplorePage({Key? key}) : super(key: key);

  @override
  State<MyExplorePage> createState() => _MyExplorePageState();
}

class _MyExplorePageState extends State<MyExplorePage> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Index 0: Explore'
    );
  }
}

class MyHeader extends StatefulWidget {
  const MyHeader({Key? key}) : super(key: key);

  @override
  State<MyHeader> createState() => _MyHeaderState();
}

class _MyHeaderState extends State<MyHeader> {
  @override
  Widget build(BuildContext context) {
    Widget searchSection = Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 28),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton(
                onPressed: () {},
                child: const Icon(Icons.notifications)
            ),
          ),
        ],
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,

    );
  }
}

