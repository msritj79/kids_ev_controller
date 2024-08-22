import 'package:flutter/material.dart';
import 'package:kids_ev_controller/dynamic_control.dart';
import 'package:kids_ev_controller/body_control.dart';

void main() {
  runApp(const CarControlApp());
}

class CarControlApp extends StatelessWidget {
  const CarControlApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RaspberryPi Controller',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CarControlHomePage(),
    );
  }
}

class CarControlHomePage extends StatefulWidget {
  const CarControlHomePage({super.key});

  @override
  State<CarControlHomePage> createState() => _CarControlHomePageState();
}

class _CarControlHomePageState extends State<CarControlHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    DynamicControlScreen(),
    BodyControlScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Dynamic Control',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Body Control',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}