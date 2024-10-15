import 'package:flutter/material.dart';
import 'package:kids_ev_controller/model/ai_chat_model.dart';
import 'package:kids_ev_controller/provider/ai_chat_provider2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AIChatScreen extends ConsumerWidget {
  const AIChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aiChatState = ref.watch(aiChatProvider); // Providerを監視
    final TextEditingController _controller = TextEditingController();

    return Column(
      children: [
        Expanded(
          child: aiChatState.when(
            data: (messages) {
              return ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return ListTile(
                    title: Text(message.role! == 'user' ? 'You' : 'AI'),
                    subtitle: Text(message.content),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
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
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () async {
                  final userMessage = _controller.text.trim();
                  if (userMessage.isNotEmpty) {
                    await ref.read(aiChatProvider.notifier).fetchChatCompletion(
                        [...aiChatState.value!, Message(content: userMessage)]);
                    _controller.clear(); // 入力フィールドをクリア
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
