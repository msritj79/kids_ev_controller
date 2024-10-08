import 'package:flutter/material.dart';

class DynamicControlScreen extends StatelessWidget {
  const DynamicControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Dynamic Control', style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          Icon(Icons.directions_car, size: 150), // ここで車のアイコンを表示
        ],
      ),
    );
  }
}
