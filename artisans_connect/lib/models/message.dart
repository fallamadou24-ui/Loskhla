import 'package:equatable/equatable.dart';

enum MessageType { text, image, audio }

class Message extends Equatable {
  const Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.type,
    required this.sentAt,
    this.content,
    this.mediaUrl,
    this.isRead = false,
  });

  final String id;
  final String conversationId;
  final String senderId;
  final MessageType type;
  final DateTime sentAt;
  final String? content;
  final String? mediaUrl;
  final bool isRead;

  Message copyWith({
    String? id,
    String? conversationId,
    String? senderId,
    MessageType? type,
    DateTime? sentAt,
    String? content,
    String? mediaUrl,
    bool? isRead,
  }) {
    return Message(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      type: type ?? this.type,
      sentAt: sentAt ?? this.sentAt,
      content: content ?? this.content,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      isRead: isRead ?? this.isRead,
    );
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      conversationId: json['conversationId'] as String,
      senderId: json['senderId'] as String,
      type: MessageType.values.firstWhere(
        (value) => value.name == (json['type'] as String? ?? 'text'),
        orElse: () => MessageType.text,
      ),
      sentAt: DateTime.tryParse(json['sentAt'] as String? ?? '') ?? DateTime.now(),
      content: json['content'] as String?,
      mediaUrl: json['mediaUrl'] as String?,
      isRead: json['isRead'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversationId': conversationId,
      'senderId': senderId,
      'type': type.name,
      'sentAt': sentAt.toIso8601String(),
      'content': content,
      'mediaUrl': mediaUrl,
      'isRead': isRead,
    };
  }

  @override
  List<Object?> get props => [
        id,
        conversationId,
        senderId,
        type,
        sentAt,
        content,
        mediaUrl,
        isRead,
      ];
}
