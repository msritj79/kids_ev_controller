import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  _AIChatScreenState createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _allMessages = [];

  final String _apiKey = dotenv.env['OPEN_AI_API_KEY']!;

  Future<void> _sendMessage(String inputMessage) async {
    setState(() {
      _allMessages.add({'role': 'user', 'content': inputMessage});
    });

    int maxInputConversations = 3;

    List<Map<String, String>> _recentMessages = [];
    int _startIndex = _allMessages.length > maxInputConversations * 2
        ? _allMessages.length - 6
        : 0;
    for (int i = _startIndex; i < _allMessages.length; i++) {
      _recentMessages.add(_allMessages[i]);
    }

    var response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-4o-mini', // モデルを指定
        'messages': [
          {'role': 'system', 'content': 'You are a helpful assistant.'},
          ..._recentMessages,
        ],
      }),
    );

    debugPrint('_recentMessages: ${_recentMessages}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String outputMessage = data['choices'][0]['message']['content'];
      debugPrint('API Response: ${response.body}');
      setState(() {
        _allMessages.add({'role': 'assistant', 'content': outputMessage});
      });
    } else {
      setState(() {
        _allMessages.add(
            {'role': 'assistant', 'content': 'Error: Failed to get response.'});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _allMessages.length,
            itemBuilder: (context, index) {
              var message = _allMessages[index];
              return ListTile(
                title: Text(message['role']! == 'user' ? 'You' : 'AI'),
                subtitle: Text(message['content']!),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Enter your message',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    _sendMessage(_controller.text);
                    _controller.clear();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
