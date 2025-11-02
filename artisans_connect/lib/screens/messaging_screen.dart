import 'package:flutter/material.dart';

import '../models/conversation.dart';
import '../services/api/messaging_api_service.dart';

class MessagingScreen extends StatefulWidget {
  const MessagingScreen({super.key});

  static const routeName = '/messaging';

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  final MessagingApiService _messagingApiService = MessagingApiService();

  Future<List<Conversation>> _loadConversations() {
    return _messagingApiService.fetchConversations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messagerie'),
      ),
      body: FutureBuilder<List<Conversation>>(
        future: _loadConversations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Erreur de chargement : ${snapshot.error}'),
            );
          }

          final conversations = snapshot.data ?? const <Conversation>[];

          if (conversations.isEmpty) {
            return const Center(child: Text('Aucune conversation pour le moment.'));
          }

          return ListView.separated(
            itemCount: conversations.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final conversation = conversations[index];
              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person_outline)),
                title: Text(conversation.lastMessagePreview ?? 'Nouvelle conversation'),
                subtitle: Text('Mis a jour le ${conversation.updatedAt}'),
                onTap: () {
                  // TODO: Navigate to conversation detail screen
                },
              );
            },
          );
        },
      ),
    );
  }
}
