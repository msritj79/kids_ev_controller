import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kids_ev_controller/providers/mqtt_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BodyControlScreen extends ConsumerStatefulWidget {
  const BodyControlScreen({super.key});

  @override
  ConsumerState<BodyControlScreen> createState() => _BodyControlScreenState();
}

class _BodyControlScreenState extends ConsumerState<BodyControlScreen> {
  bool _isHeadlightPressed = false;
  bool _isTaillightPressed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // ref.watch(beebotteMQTTServiceProvider);

    return Stack(
      alignment: Alignment.center,
      children: [
        const Image(image: AssetImage('assets/LC500.jpg')),
        if (_isHeadlightPressed)
          const Image(image: AssetImage('assets/LC500_lightOn.png')),
        if (_isTaillightPressed)
          const Image(image: AssetImage('assets/LC500_lightOn.png')),

        HeadlightWidget(
          isPressed: _isHeadlightPressed,
          onTap: _toggleHeadlights,
          position:
              // const Offset(185, 425),
              Offset(screenWidth * 0.3, screenHeight * 0.38),
        ),
        // Right headlight
        HeadlightWidget(
          isPressed: _isHeadlightPressed,
          onTap: _toggleHeadlights,
          position:
              // const Offset(-185, 425), // Adjust based on the headlight position
              Offset(-screenWidth * 0.3, screenHeight * 0.38),
        ),
        TaillightWidget(
          isPressed: _isTaillightPressed,
          onTap: _toggleTaillights,
          position:
              // const Offset(200, 20), // Adjust based on the headlight position
              Offset(screenWidth * 0.33, screenHeight * 0.05),
        ),

        // Right headlight
        TaillightWidget(
          isPressed: _isTaillightPressed,
          onTap: _toggleTaillights,
          position:
              // const Offset(-200, 20), // Adjust based on the headlight position
              Offset(-screenWidth * 0.33, screenHeight * 0.05),
        ),
      ],
    );
  }

  void _toggleHeadlights() {
    // ヘッドライトをオン/オフする関数
    setState(() {
      _isHeadlightPressed = !_isHeadlightPressed; // Toggle the state
    });
    print('Headlights toggled: $_isHeadlightPressed');
    ref.read(beebotteMQTTServiceProvider.notifier).publish(
        'LC500/command',
        _isHeadlightPressed
            ? jsonEncode({"headLight": "ON"})
            : jsonEncode({"headLight": "OFF"}));
  }

  void _toggleTaillights() {
    // ヘッドライトをオン/オフする関数
    setState(() {
      _isTaillightPressed = !_isTaillightPressed; // Toggle the state
    });
    print('Taillights toggled: $_isTaillightPressed');
    ref.read(beebotteMQTTServiceProvider.notifier).publish(
        'LC500/command',
        _isTaillightPressed
            ? jsonEncode({"tailLight": "ON"})
            : jsonEncode({"tailLight": "OFF"}));
  }

  void _honkHorn() {
    // ホーンを鳴らす関数
    print('Horn honked');
  }

  void _playMusic() {
    // ミュージックを再生する関数
    print('Music played');
  }

  @override
  void dispose() {
    ref
        .read(beebotteMQTTServiceProvider.notifier)
        .client
        .disconnect(); // ウィジェットが破棄されたときにMQTTクライアントを切断
    super.dispose();
  }
}

class HeadlightWidget extends StatelessWidget {
  final bool isPressed;
  final VoidCallback onTap;
  final Offset position;

  const HeadlightWidget({
    Key? key,
    required this.isPressed,
    required this.onTap,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx > 0 ? position.dx : null,
      right: position.dx < 0 ? -position.dx : null,
      top: position.dy,
      child: GestureDetector(
        onTap: onTap,
        child: ClipOval(
          child: Container(
            width: 30,
            height: 50,
            decoration: BoxDecoration(
              color: isPressed
                  ? Colors.yellow.withOpacity(0.5) // 半透明の黄色（50%透明）
                  : Colors.black.withOpacity(0.2), // 非表示
              // shape: BoxShape.circle,
              // borderRadius: BorderRadius.circular(500),
            ),
            // color: isPressed ? Colors.yellow : Colors.black, // Make it invisible
          ),
        ),
      ),
    );
  }
}

class TaillightWidget extends StatelessWidget {
  final bool isPressed;
  final VoidCallback onTap;
  final Offset position;

  const TaillightWidget({
    Key? key,
    required this.isPressed,
    required this.onTap,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx > 0 ? position.dx : null,
      right: position.dx < 0 ? -position.dx : null,
      top: position.dy,
      child: GestureDetector(
        onTap: onTap,
        child: ClipOval(
          child: Container(
            width: 30,
            height: 50,
            decoration: BoxDecoration(
              color: isPressed
                  ? Colors.red.withOpacity(0.5) // 半透明の黄色（50%透明）
                  : Colors.white.withOpacity(0.2), // 非表示
              // shape: BoxShape.circle,
              // borderRadius: BorderRadius.circular(500),
            ),
            // color: isPressed ? Colors.yellow : Colors.black, // Make it invisible
          ),
        ),
      ),
    );
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         const Image(image: AssetImage('assets/LC500.jpg')),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             IconButton(
  //               icon: const Icon(Icons.highlight),
  //               iconSize: 50,
  //               onPressed: () {
  //                 _toggleHeadlights();
  //               },
  //             ),
  //             const SizedBox(width: 20),
  //             IconButton(
  //               icon: const Icon(Icons.volume_up),
  //               iconSize: 50,
  //               onPressed: () {
  //                 _honkHorn();
  //               },
  //             ),
  //             const SizedBox(width: 20),
  //             IconButton(
  //               icon: const Icon(Icons.music_note),
  //               iconSize: 50,
  //               onPressed: () {
  //                 _playMusic();
  //               },
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
// }
