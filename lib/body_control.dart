import 'package:flutter/material.dart';

class BodyControlScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Body Control'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Body Control', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Image.network(
                'https://media.gqjapan.jp/photos/64dc28f744fd32f782fa3ed0/16:9/w_1920,c_limit/lexus-lc500-Inspiration-1.jpg'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.highlight),
                  iconSize: 50,
                  onPressed: () {
                    _toggleHeadlights();
                  },
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.volume_up),
                  iconSize: 50,
                  onPressed: () {
                    _honkHorn();
                  },
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.music_note),
                  iconSize: 50,
                  onPressed: () {
                    _playMusic();
                  },
                ),
              ],
            ),
          ],
        ),
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