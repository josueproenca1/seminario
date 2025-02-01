import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Remover a faixa de debug
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key}); 

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _expression = "";
  double _num1 = 0.0;
  String _operator = "";
  bool _isNewNumber = true;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        _output = "0";
        _expression = "";
        _num1 = 0.0;
        _operator = "";
        _isNewNumber = true;
      } else if (buttonText == "C") {
        _output = _output.substring(0, _output.length - 1);
        _expression = _expression.substring(0, _expression.length - 1);
        if (_output.isEmpty) _output = "0";
        if (_expression.isEmpty) _expression = "";
      } else if (buttonText == "%") {
        double num = double.parse(_output) / 100;
        _output = num.toString();
        _expression += buttonText;
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "x" || buttonText == "/") {
        if (!_isNewNumber) {
          _calculate();
          _expression = _output;
        }
        _operator = buttonText;
        _num1 = double.parse(_output);
        _expression += " $buttonText ";
        _isNewNumber = true;
      } else if (buttonText == "=") {
        _calculate();
        _expression += " $buttonText $_output";
        _num1 = 0.0;
        _operator = "";
        _isNewNumber = true;
      } else if (buttonText == "lg") {
        double num = log(double.parse(_output)) / ln10;
        _output = num.toString();
        _expression += "lg";
      } else if (buttonText == "ln") {
        double num = log(double.parse(_output));
        _output = num.toString();
        _expression += "ln";
      } else if (buttonText == "sin") {
        double degrees = double.parse(_output);
        if (degrees == 0 || degrees == 180 || degrees == 360) {
          _output = "0";
        } else {
          double radians = degrees * pi / 180;
          _output = sin(radians).toString();
        }
        _expression += "sin";
      } else if (buttonText == "cos") {
        double degrees = double.parse(_output);
        if (degrees == 90 || degrees == 270) {
          _output = "0";
        } else if (degrees == 0 || degrees == 180 || degrees == 360) {
          _output = "1";
        } else {
          double radians = degrees * pi / 180;
          _output = cos(radians).toString();
        }
        _expression += "cos";
      } else if (buttonText == "tan") {
        double degrees = double.parse(_output);
        if (degrees == 90 || degrees == 270) {
          _output = "Undefined";
        } else {
          double radians = degrees * pi / 180;
          _output = tan(radians).toString();
        }
        _expression += "tan";
      } else if (_output == "0" || _isNewNumber) {
        _output = buttonText;
        _expression += buttonText;
        _isNewNumber = false;
      } else {
        _output += buttonText;
        _expression += buttonText;
      }
    });
  }

  void _calculate() {
    if (_operator == "+") {
      _output = (_num1 + double.parse(_output)).toString();
    } else if (_operator == "-") {
      _output = (_num1 - double.parse(_output)).toString();
    } else if (_operator == "x") {
      _output = (_num1 * double.parse(_output)).toString();
    } else if (_operator == "/") {
      if (double.parse(_output) != 0) {
        _output = (_num1 / double.parse(_output)).toString();
      } else {
        _output = "Error";
      }
    }
  }

  Widget _buildButton(String buttonText, {Color? color, Color? textColor}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey[800],  // Cor de fundo dos botões
            foregroundColor: textColor ?? Colors.white,  // Cor do texto
            padding: EdgeInsets.all(20.0),
            textStyle: TextStyle(fontSize: 24.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("",),
        
        backgroundColor: Colors.black12,  // Cor do app bar
      ),
      backgroundColor: Colors.black,  // Cor de fundo da tela
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(24.0),
              child: Text(
                _expression,
                style: TextStyle(fontSize: 24.0, color: Colors.white),  // Texto em branco
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(24.0),
              child: Text(
                _output,
                style: TextStyle(fontSize: 48.0, color: Colors.white),  // Texto em branco
              ),
            ),
            Divider(color: Colors.white),  // Linha divisória branca
            Column(
              children: [
                Row(
                  children: [
                    _buildButton("AC", color: Colors.red),
                    _buildButton("C", color: Colors.grey),
                    _buildButton("%", color: Colors.orange),
                    _buildButton("/", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("x", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("-", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("+", color: Colors.grey),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("0"),
                    _buildButton(",", color: Colors.grey),
                    _buildButton("=", color: Colors.blue, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("sin", color: Colors.orange),
                    _buildButton("cos", color: Colors.orange),
                    _buildButton("tan", color: Colors.orange),
                    _buildButton("lg", color: Colors.orange),
                    _buildButton("ln", color: Colors.orange),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
