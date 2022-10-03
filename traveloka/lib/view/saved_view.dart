import 'package:flutter/material.dart';
import '../components/search_bar.dart';

class MySavedPage extends StatefulWidget {
  const MySavedPage({Key? key}) : super(key: key);

  @override
  State<MySavedPage> createState() => _MySavedPageState();
}

class _MySavedPageState extends State<MySavedPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        SearchBar(),
      ],
    );
  }
}
