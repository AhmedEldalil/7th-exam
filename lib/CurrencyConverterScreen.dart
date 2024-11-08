import 'package:kpppp/main.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyConverterScreen extends StatefulWidget {
  @override
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  String? _fromCurrency;
  String? _toCurrency;
  String _conversionResult = '';
  String _errorMessage = '';

  final List<String> currencies = [
    'USD',
    'EUR',
    'GBP',
    'INR',
    'AUD',
    'CAD',
    'JPY',
    'CNY',
    'MXN',
    'BRL',
    'RUB',
    'ZAR',
  ];

  Future<void> convertCurrency(String fromCurrency, String toCurrency) async {
    final apiUrl =
        'https://v6.exchangerate-api.com/v6/0d3a8abc6c80aabc0bcd5a4d/latest/$fromCurrency';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final rates = data['conversion_rates'];

        if (rates != null && rates.containsKey(toCurrency)) {
          final conversionRate = rates[toCurrency];
          setState(() {
            _conversionResult =
                '1 $fromCurrency is equivalent to $conversionRate $toCurrency';
            _errorMessage = '';
          });
        } else {
          setState(() {
            _conversionResult = '';
            _errorMessage = 'Target currency ($toCurrency) not found.';
          });
        }
      } else {
        setState(() {
          _conversionResult = '';
          _errorMessage =
              'Failed to fetch exchange rates. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _conversionResult = '';
        _errorMessage = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: Main.the_app_bar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              hint: Text('Select From Currency'),
              value: _fromCurrency,
              onChanged: (newValue) {
                setState(() {
                  _fromCurrency = newValue;
                });
              },
              items: currencies.map((currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              hint: Text('Select To Currency'),
              value: _toCurrency,
              onChanged: (newValue) {
                setState(() {
                  _toCurrency = newValue;
                });
              },
              items: currencies.map((currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_fromCurrency != null && _toCurrency != null) {
                  convertCurrency(_fromCurrency!, _toCurrency!);
                } else {
                  setState(() {
                    _errorMessage = 'Please select both currencies.';
                    _conversionResult = '';
                  });
                }
              },
              child: Text('Convert'),
            ),
            SizedBox(height: 16),
            if (_conversionResult.isNotEmpty)
              Text(
                _conversionResult,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
