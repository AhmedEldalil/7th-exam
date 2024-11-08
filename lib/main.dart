import 'package:kpppp/Home.dart';
import 'package:kpppp/SignIn.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SignIn(),
    routes: {'/home': (context) => Home(), '/sign_in': (context) => SignIn()},
  ));
}

class Main {
  static String name = '';

  static AppBar the_app_bar(BuildContext) {
    return AppBar(
      actions: [
        PopupMenuButton(itemBuilder: (context) {
          return [
            PopupMenuItem(child: Text(Main.name)),
            PopupMenuItem(
              child: TextButton(
                child: Text('Sign out'),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/sign_in', (route) => false);
                },
              ),
            )
          ];
        })
      ],
    );
  }
}
