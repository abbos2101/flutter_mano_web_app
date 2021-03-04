import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume_app/data/widget/widget.dart';
import 'package:flutter_resume_app/home_screen.dart';
import 'bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  static Widget screen() => HomeScreen(
        child: BlocProvider(
          create: (context) => LoginBloc(context),
          child: LoginScreen(),
        ),
      );

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc bloc;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    bloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(40),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Text(
              "Ma'no",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 20),
            WTextField(
              controller: usernameController,
              hint: "Foydalanuvchi nomi",
            ),
            SizedBox(height: 10),
            WTextField(
              controller: passwordController,
              hint: "Maxfiy so'z",
              obscureText: true,
            ),
            SizedBox(height: 20),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) => WButton(
                onPressed: () => bloc.add(SignEvent(
                  username: usernameController.text,
                  password: passwordController.text,
                )),
                enable: state is LoadingState != true,
                text: 'Kirish',
                fontSize: 16,
                width: double.infinity,
                color: Colors.orangeAccent,
                circular: 10,
              ),
            ),
            SizedBox(height: 40),
            Text(
              "Siz oldin ro'yxatdan o'tmaganmisiz?",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) => WButton(
                onPressed: () => bloc.add(SignupLaunchEvent()),
                enable: state is LoadingState != true,
                text: "Ro'yxatdan o'tish",
                fontSize: 16,
                width: double.infinity,
                color: Colors.orangeAccent,
                circular: 10,
              ),
            ),
            SizedBox(height: 10),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoadingState) return WLoading(height: 40);
                return SizedBox();
              },
            ),
          ],
        )),
      ),
    );
  }
}
