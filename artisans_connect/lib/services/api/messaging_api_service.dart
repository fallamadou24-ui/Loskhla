import '../../models/conversation.dart';
import '../../models/message.dart';
import 'api_constants.dart';

class MessagingApiService {
  const MessagingApiService();

  /// Recuperer les conversations de l utilisateur connecte.
  Future<List<Conversation>> fetchConversations() async {
    assert(apiBaseUrl.isNotEmpty);
    // TODO: Implement API call using apiBaseUrl
    return Future.value(const []);
  }

  /// Recuperer les messages d une conversation.
  Future<List<Message>> fetchMessages(String conversationId) async {
    assert(apiBaseUrl.isNotEmpty);
    // TODO: Implement API call using apiBaseUrl
    return Future.value(const []);
  }

  /// Envoyer un message texte/photo/audio.
  Future<Message> sendMessage({
    required String conversationId,
    required String senderId,
    required MessageType type,
    String? content,
    String? mediaUrl,
  }) async {
    assert(apiBaseUrl.isNotEmpty);
    // TODO: Implement API call using apiBaseUrl
    return Future.value(
      Message(
        id: 'temp-id',
        conversationId: conversationId,
        senderId: senderId,
        type: type,
        sentAt: DateTime.now(),
        content: content,
        mediaUrl: mediaUrl,
      ),
    );
  }
}
