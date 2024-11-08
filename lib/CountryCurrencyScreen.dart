import 'dart:convert';
import 'package:kpppp/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryCurrencyScreen extends StatefulWidget {
  @override
  _CountryCurrencyScreenState createState() => _CountryCurrencyScreenState();
}

class _CountryCurrencyScreenState extends State<CountryCurrencyScreen> {
  String? selectedCountry;
  String currency = '';

  List<String> countries = [
    'India',
    'United States',
    'United Kingdom',
    'Canada',
    'Australia',
    'Germany',
    'France',
    'Brazil',
    'Japan',
  ];

  Future<void> getCurrencyForCountry(String countryName) async {
    final apiUrl = 'https://restcountries.com/v3.1/name/$countryName';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data.isNotEmpty) {
          var country = data[0];
          String newCurrency = 'N/A';

          if (country['currencies'] != null) {
            newCurrency = country['currencies'].keys.join(', ');
          }

          setState(() {
            currency = newCurrency;
          });
        } else {
          setState(() {
            currency = 'Country not found.';
          });
        }
      } else {
        setState(() {
          currency =
              'Failed to fetch country data. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        currency = 'Error: $e';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    selectedCountry = countries[0];
    getCurrencyForCountry(selectedCountry!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: Main.the_app_bar(context),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedCountry,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCountry = newValue;
                  getCurrencyForCountry(selectedCountry!);
                });
              },
              items: countries.map<DropdownMenuItem<String>>((String country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Currency: $currency',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
