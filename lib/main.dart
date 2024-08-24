import 'package:flutter/material.dart';
import 'package:kids_ev_controller/dynamic_control.dart';
import 'package:kids_ev_controller/body_control.dart';
import 'package:kids_ev_controller/status_check.dart';
import 'package:kids_ev_controller/map.dart';

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
    StatusCheck(),
    Map(),
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
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Dynamic Control',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Body Control',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.visibility),
            label: 'Status Check',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
