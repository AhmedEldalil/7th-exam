import 'package:kpppp/Read_data.dart';
import 'package:kpppp/main.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignIn();
  }
}

class _SignIn extends State<SignIn> {
  Read_data name = Read_data('enter your name'),
      password = Read_data(
        'enter the password',
        dont_show_password: true,
      );
  String display = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 196, 137, 133),
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: Text(
          'Login',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            name,
            SizedBox(
              height: 20,
            ),
            password,
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  String name_str = name.getcontrollor().text,
                      password_str = password.getcontrollor().text;

                  if (name_str.isEmpty || password_str.isEmpty)
                    setState(() {
                      display = 'please enter the whole requirments';
                    });
                  else {
                    if (password_str != '1234')
                      setState(() {
                        display = 'the password is wrong';
                      });
                    else {
                      Main.name = name_str;
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (route) => false);
                    }
                  }
                },
                child: Text('submit')),
            SizedBox(
              height: 20,
            ),
            Text(
              display,
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
