import 'package:flutter/material.dart';

class BodyControlScreen extends StatelessWidget {
  const BodyControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Body Control', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 20),
          const Image(image: AssetImage('assets/lexus.jpg')),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.highlight),
                iconSize: 50,
                onPressed: () {
                  _toggleHeadlights();
                },
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.volume_up),
                iconSize: 50,
                onPressed: () {
                  _honkHorn();
                },
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.music_note),
                iconSize: 50,
                onPressed: () {
                  _playMusic();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _toggleHeadlights() {
    // ヘッドライトをオン/オフする関数
    print('Headlights toggled');
  }

  void _honkHorn() {
    // ホーンを鳴らす関数
    print('Horn honked');
  }

  void _playMusic() {
    // ミュージックを再生する関数
    print('Music played');
  }
}
