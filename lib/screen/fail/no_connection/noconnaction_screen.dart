import 'package:flutter/material.dart';
import 'package:flutter_resume_app/home_screen.dart';
import 'package:flutter_resume_app/screen/auth/login/login_screen.dart';
import 'package:provider/provider.dart';

import 'noconnection_provider.dart';

class NoConnectionScreen extends StatefulWidget {
  static Widget screen() => HomeScreen(
        child: ChangeNotifierProvider(
          create: (_) => NoConnectionProvider(),
          child: NoConnectionScreen(),
        ),
      );

  @override
  _NoConnectionScreenState createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/image_error.png'),
            Text(
              'Internetda ulanish bilan muammo',
              style: TextStyle(fontSize: 20),
            ),
            MaterialButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen.screen()),
              ),
              child: Text('Qayta ulanish'),
            ),
          ],
        ),
      ),
    ); //Center(child: Text('No Connection'));
  }
}
