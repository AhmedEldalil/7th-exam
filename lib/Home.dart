import 'package:kpppp/CountryCurrencyScreen.dart';
import 'package:kpppp/CurrencyConverterScreen.dart';
import 'package:kpppp/main.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: Main.the_app_bar(context),
        body: Container(
            padding: EdgeInsets.all(15),
            child: Column(children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.3,
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CurrencyConverterScreen()),
                        );
                      },
                      child: Text('currency convert'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                      )),
                  Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CountryCurrencyScreen()),
                        );
                      },
                      child: Text('currency of countries'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                      )),
                ],
              ),
            ])));
  }
}
