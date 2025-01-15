import 'package:flutter/material.dart';

class PasswordCriteria extends StatelessWidget {
  final String password;

  PasswordCriteria({required this.password});

  @override
  Widget build(BuildContext context) {
    final criteria = [
      {'label': 'At least 6 characters', 'met': password.length >= 6},
      {
        'label': 'Contains uppercase letter',
        'met': RegExp(r'[A-Z]').hasMatch(password)
      },
      {
        'label': 'Contains lowercase letter',
        'met': RegExp(r'[a-z]').hasMatch(password)
      },
      {'label': 'Contains a number', 'met': RegExp(r'\d').hasMatch(password)},
      {
        'label': 'Contains special character',
        'met': RegExp(r'[^A-Za-z0-9]').hasMatch(password)
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: criteria.map((item) {
        bool isMet = item['met'] as bool; // Explicitly cast to bool
        String label = item['label'] as String;
        return Row(
          children: [
            Icon(
              isMet ? Icons.check : Icons.close,
              color: isMet ? Colors.green : Colors.grey,
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(color: isMet ? Colors.green : Colors.grey),
            ),
          ],
        );
      }).toList(),
    );
  }
}

class PasswordStrengthMeter extends StatelessWidget {
  final String password;

  PasswordStrengthMeter({required this.password});

  int getStrength(String pass) {
    int strength = 0;
    if (pass.length >= 6) strength++;
    if (RegExp(r'[a-z]').hasMatch(pass) && RegExp(r'[A-Z]').hasMatch(pass))
      strength++;
    if (RegExp(r'\d').hasMatch(pass)) strength++;
    if (RegExp(r'[^a-zA-Z\d]').hasMatch(pass)) strength++;
    return strength;
  }

  Color getColor(int strength) {
    switch (strength) {
      case 0:
        return Colors.red[500]!;
      case 1:
        return Colors.red[400]!;
      case 2:
        return Colors.yellow[500]!;
      case 3:
        return Colors.yellow[400]!;
      default:
        return Colors.green[500]!;
    }
  }

  String getStrengthText(int strength) {
    switch (strength) {
      case 0:
        return 'Very Weak';
      case 1:
        return 'Weak';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      default:
        return 'Strong';
    }
  }

  @override
  Widget build(BuildContext context) {
    final strength = getStrength(password);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Password strength', style: TextStyle(color: Colors.grey)),
            Text(getStrengthText(strength),
                style: TextStyle(color: Colors.grey)),
          ],
        ),
        Row(
          children: List.generate(4, (index) {
            return Container(
              height: 8,
              width: MediaQuery.of(context).size.width * 0.2,
              margin: EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: index < strength ? getColor(strength) : Colors.grey[600],
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
        SizedBox(height: 8),
        PasswordCriteria(password: password),
      ],
    );
  }
}
