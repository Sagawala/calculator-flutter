import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '0';
  String _currentInput = '';
  double _firstNumber = 0;
  double _secondNumber = 0;
  String _operator = '';
  bool _shouldClear = false;

  void _handleButtonPressed(String value) {
    setState(() {
      if (_shouldClear) {
        _currentInput = '';
        _shouldClear = false;
      }
      if (value == 'C') {
        _currentInput = '';
        _output = '0';
        _firstNumber = 0;
        _secondNumber = 0;
        _operator = '';
      } else if (value == '=' && _operator.isNotEmpty && _currentInput.isNotEmpty) {
        _secondNumber = double.parse(_currentInput);
        if (_operator == '+') {
          _output = (_firstNumber + _secondNumber).toString();
        } else if (_operator == '-') {
          _output = (_firstNumber - _secondNumber).toString();
        } else if (_operator == '*') {
          _output = (_firstNumber * _secondNumber).toString();
        } else if (_operator == '/') {
          _output = (_firstNumber / _secondNumber).toString();
        }
        _operator = '';
        _shouldClear = true;
      } else if (_operators.contains(value)) {
        if (_operator.isNotEmpty && _currentInput.isNotEmpty) {
          _firstNumber = double.parse(_currentInput);
          _currentInput = '';
        }
        _operator = value;
      } else {
        _currentInput += value;
      }
    });
  }

  static const List<String> _operators = ['+', '-', '*', '/'];

  Widget _buildButton(String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => _handleButtonPressed(label),
          child: Text(
            label,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/'),
            ],
          ),
          Row(
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('*'),
            ],
          ),
          Row(
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            children: [
              _buildButton('0'),
              _buildButton('C'),
              _buildButton('='),
              _buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }
}