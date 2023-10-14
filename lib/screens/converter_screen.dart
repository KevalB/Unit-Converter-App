import 'package:flutter/material.dart';

class ConverterScreen extends StatefulWidget {
  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  double inputValue = 0.0;
  double resultValue = 0.0;
  List<String> units = [
    'Meter',
    'Kilometer',
    'Kilogram',
    'Gram',
    'Celsius',
    'Fahrenheit',
    'Square Meter',
    'Square Foot'
  ];
  String fromUnit = 'Meter';
  String toUnit = 'Meter';
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Converter'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    inputValue = double.tryParse(value) ?? 0.0;
                  });
                }
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                DropdownButton<String>(
                  value: fromUnit,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        fromUnit = newValue;
                        errorMessage = '';
                      });
                    }
                  },
                  items: units.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Text('to'),
                DropdownButton<String>(
                  value: toUnit,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        toUnit = newValue;
                        errorMessage = '';
                      });
                    }
                  },
                  items: units.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              errorMessage.isNotEmpty ? errorMessage : 'Result: $resultValue',
              style: TextStyle(
                fontSize: 18.0,
                color: errorMessage.isNotEmpty ? Colors.red : null,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement the conversion logic here
                setState(() {
                  errorMessage = '';
                  resultValue = convert(inputValue, fromUnit, toUnit);
                });
              },
              child: Text('Convert'),
            ),
          ],
        ),
      ),
    );
  }

  double convert(double inputValue, String fromUnit, String toUnit) {
    if (fromUnit == 'Meter' && toUnit == 'Kilometer') {
      return inputValue / 1000; // Meter to Kilometer
    } else if (fromUnit == 'Kilometer' && toUnit == 'Meter') {
      return inputValue * 1000; // Kilometer to Meter
    } else if (fromUnit == 'Kilogram' && toUnit == 'Gram') {
      return inputValue * 1000; // Kilogram to Gram
    } else if (fromUnit == 'Gram' && toUnit == 'Kilogram') {
      return inputValue / 1000; // Gram to Kilogram
    } else if (fromUnit == 'Celsius' && toUnit == 'Fahrenheit') {
      return (inputValue * 9 / 5) + 32; // Celsius to Fahrenheit
    } else if (fromUnit == 'Fahrenheit' && toUnit == 'Celsius') {
      return (inputValue - 32) * 5 / 9; // Fahrenheit to Celsius
    } else if (fromUnit == 'Square Meter' && toUnit == 'Square Foot') {
      return inputValue * 10.764; // Square Meter to Square Foot
    } else if (fromUnit == 'Square Foot' && toUnit == 'Square Meter') {
      return inputValue / 10.764; // Square Foot to Square Meter
    }
    if (fromUnit == 'Meter' && toUnit == 'Square Meter') {
      return inputValue * 2; // Meter to Square Meter
    } else if (fromUnit == 'Square Meter' && toUnit == 'Meter') {
      return inputValue / 2; // Square Meter to Meter
    } else {
      // Invalid conversion
      errorMessage = 'Invalid conversion';
      return inputValue;
    }
  }
}
