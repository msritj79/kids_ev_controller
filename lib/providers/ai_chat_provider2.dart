import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kids_ev_controller/models/ai_chat_model.dart'; // モデルをインポート
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'ai_chat_provider2.g.dart';

class AiChatState {
  final bool isReplying;
  final List<Message> messageList;

  AiChatState({required this.isReplying, required this.messageList});

  // to enable changing one state value
  AiChatState copyWith({bool? isReplying, List<Message>? messageList}) {
    return AiChatState(
      isReplying: isReplying ?? this.isReplying,
      messageList: messageList ?? this.messageList,
    );
  }
}

// Notifierの定義
@riverpod
class AiChat extends _$AiChat {
  List<Message> messageList = [];
  // 初期データとして空のメッセージリストを返す
  @override
  Future<AiChatState> build() async {
    return AiChatState(isReplying: false, messageList: []);
  }

  Future<void> addMessage(Message message, {int maxMessageCount = 3}) async {
    final uri = Uri.https('api.openai.com', '/v1/chat/completions');
    final apiKey = dotenv.env['OPEN_AI_API_KEY']!;

    final updatedMessageList = [...state.value!.messageList, message];
    // to show user massage
    state = AsyncValue.data(
      state.value!.copyWith(messageList: updatedMessageList),
    );

    try {
      state = AsyncValue.data(
        state.value!.copyWith(isReplying: true),
      );
      // to save the api costs, only send the last 3 messages
      final recentMessages = updatedMessageList.length > maxMessageCount
          ? updatedMessageList
              .sublist(updatedMessageList.length - maxMessageCount)
          : updatedMessageList;

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
      state = AsyncValue.data(
        state.value!.copyWith(isReplying: false),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newMessage = Message.fromJson(data['choices'][0]['message']);

        // メッセージリストに新しいメッセージを追加して更新
        state = AsyncValue.data(
          state.value!
              .copyWith(messageList: [...updatedMessageList, newMessage]),
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
      state = AsyncValue.data(
        state.value!.copyWith(isReplying: false),
      );
    }
  }
}



// // old
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:kids_ev_controller/models/ai_chat_model.dart'; // モデルをインポート
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// part 'ai_chat_provider2.g.dart';

// // Notifierの定義
// @riverpod
// class AiChat extends _$AiChat {
//   bool isReplying = false;
//   // 初期データとして空のメッセージリストを返す
//   @override
//   Future<List<Message>> build() async {
//     return [];
//   }

//   Future<void> fetchChatCompletion(List<Message> messages,
//       {int recentMessageCount = 3}) async {
//     final uri = Uri.https('api.openai.com', '/v1/chat/completions');
//     final apiKey = dotenv.env['OPEN_AI_API_KEY']!;

//     try {
//       isReplying = true;
//       // messagesリストの末尾から recentMessageCount 個のメッセージを取得
//       final recentMessages = messages.length > recentMessageCount
//           ? messages.sublist(messages.length - recentMessageCount)
//           : messages; // メッセージが指定した数より少ない場合はすべてを取得

//       // リクエストボディの作成
//       final requestBody = jsonEncode({
//         'model': 'gpt-4o',
//         'messages': recentMessages.map((message) => message.toJson()).toList(),
//       });

//       // APIリクエストの送信
//       final response = await http.post(
//         uri,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $apiKey',
//         },
//         body: requestBody,
//       );
//       isReplying = false;

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final newMessage = Message.fromJson(data['choices'][0]['message']);

//         // メッセージリストに新しいメッセージを追加して更新
//         state = AsyncValue.data(
//           [...messages, newMessage],
//         );
//       } else {
//         throw Exception('Failed to fetch chat completion');
//       }
//     } catch (e, stacktrace) {
//       // エラーハンドリング
//       state = AsyncValue.error(
//         e,
//         stacktrace,
//       );
//       isReplying = false;
//     }
//   }
// }
