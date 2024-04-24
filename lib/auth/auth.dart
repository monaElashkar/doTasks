import 'package:flutter/material.dart';
import 'package:todo/auth/login.dart';
import 'package:todo/auth/register.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const String routeName = "Auth";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Auth"),
          bottom:TabBar(
            indicatorColor: Colors.white,
            indicatorPadding: EdgeInsets.only(bottom: 4),
            tabs: [
              Tab(child: Text("Login"),),
              Tab(child: Text("Register"),),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LoginTab(),
            RegisterTab()
          ],
        ),
      ),
    );
  }
}
