import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kids_ev_controller/model/ai_chat_model.dart'; // モデルをインポート
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'ai_chat_provider2.g.dart';

// Notifierの定義
@riverpod
class AiChat extends _$AiChat {
  // 初期データとして空のメッセージリストを返す
  @override
  Future<List<Message>> build() async {
    return [];
  }

  Future<void> fetchChatCompletion(List<Message> messages,
      {int recentMessageCount = 3}) async {
    final uri = Uri.https('api.openai.com', '/v1/chat/completions');
    final apiKey = dotenv.env['OPEN_AI_API_KEY']!;

    try {
      // messagesリストの末尾から recentMessageCount 個のメッセージを取得
      final recentMessages = messages.length > recentMessageCount
          ? messages.sublist(messages.length - recentMessageCount)
          : messages; // メッセージが指定した数より少ない場合はすべてを取得

      // リクエストボディの作成
      final requestBody = jsonEncode({
        'model': 'gpt-4o',
        'messages': recentMessages.map((message) => message.toJson()).toList(),
      });

      // APIリクエストの送信
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newMessage = Message.fromJson(data['choices'][0]['message']);

        // メッセージリストに新しいメッセージを追加して更新
        state = AsyncValue.data(
          [...messages, newMessage],
        );
      } else {
        throw Exception('Failed to fetch chat completion');
      }
    } catch (e, stacktrace) {
      // エラーハンドリング
      state = AsyncValue.error(
        e,
        stacktrace,
      );
    }
  }
}
