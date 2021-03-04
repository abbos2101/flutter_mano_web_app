import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'saved_provider.dart';

class SavedScreen extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => screen());

  static Widget screen() => ChangeNotifierProvider(
        create: (_) => SavedProvider(),
        child: SavedScreen(),
      );

  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  void initState() {
    print('saved');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Saved')),
    );
  }
}
