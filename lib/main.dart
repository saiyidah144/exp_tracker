import 'package:exp_tracker/First_view.dart';
import 'package:exp_tracker/sign_up_View.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'providerWidget.dart';
import 'navigation_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final primaryColor = const Color(0xFFCE93D8);
  @override
  Widget build(BuildContext context) {
    return Provider(
        auth: AuthService(),
        db: Firestore.instance,
    child: MaterialApp(
    title: "EXPTracker",
       // color: primaryColor,
    theme: ThemeData(
      backgroundColor: primaryColor,
    ),
    home: HomeController(),
    routes: <String, WidgetBuilder>{
    '/signUp': (BuildContext context) => SignUpView(authFormType: AuthFormType.signUp),
    '/signIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.signIn),
      '/anonymousSignIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.anonymous),
      '/convertUser': (BuildContext context) => SignUpView(authFormType: AuthFormType.convert),
    }
    )
  );
  }
}
class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<String>(
        stream: auth.onAuthStateChanged,
        builder: (context, AsyncSnapshot<String> snapshot) {
      if (snapshot.connectionState == ConnectionState.active) {
        final bool signedIn = snapshot.hasData;
        return signedIn ? Home() : FirstView();
      }
      return CircularProgressIndicator();
    },
    );
  }
}