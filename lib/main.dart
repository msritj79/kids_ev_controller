import 'package:flutter/material.dart';
import 'package:kids_ev_controller/provider/mqtt_service_provider.dart';
import 'screens/dynamic_control.dart';
import 'screens/body_control.dart';
import 'screens/status_check.dart';
import 'screens/map.dart';
import 'screens/ai_chat.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(
    const ProviderScope(
      child: CarControlApp(),
    ),
  );
}

class CarControlApp extends StatelessWidget {
  const CarControlApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Controller',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProviderInitializer(),
    );
  }
}

class ProviderInitializer extends ConsumerWidget {
  const ProviderInitializer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // プロバイダーをインスタンス化
    ref.read(beebotteMQTTServiceProvider.notifier).connect();
    // connectMQTT(context, ref);
    return const TopScreen();
  }

  // Future<void> connectMQTT(BuildContext context, WidgetRef ref) async =>
  //     ref.read(beebotteMQTTServiceProvider.notifier).connect();
}

class TopScreen extends StatefulWidget {
  const TopScreen({super.key});

  @override
  State<TopScreen> createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetList = <Widget>[
    const DynamicControlScreen(),
    const BodyControlScreen(),
    const StatusCheckScreen(),
    const MapScreen(),
    const AIChatScreen(),
  ];

  final List<String> _titleList = <String>[
    'Dynamic Control',
    'Body Control',
    'Status Check',
    'Map',
    'AI Chat',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          _titleList.elementAt(_selectedIndex),
          style: const TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetList,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'AI Chat',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
