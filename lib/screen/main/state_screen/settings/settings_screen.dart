import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => screen());

  static Widget screen() => ChangeNotifierProvider(
        create: (_) => SettingsProvider(),
        child: SettingsScreen(),
      );

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    print('settings');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Settings')),
    );
  }
}
