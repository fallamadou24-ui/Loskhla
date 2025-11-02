import 'package:equatable/equatable.dart';

import 'message.dart';

class Conversation extends Equatable {
  const Conversation({
    required this.id,
    required this.participantIds,
    required this.messages,
    required this.updatedAt,
    this.lastMessagePreview,
    this.artisanId,
    this.particularId,
  });

  final String id;
  final List<String> participantIds;
  final List<Message> messages;
  final DateTime updatedAt;
  final String? lastMessagePreview;
  final String? artisanId;
  final String? particularId;

  Conversation copyWith({
    String? id,
    List<String>? participantIds,
    List<Message>? messages,
    DateTime? updatedAt,
    String? lastMessagePreview,
    String? artisanId,
    String? particularId,
  }) {
    return Conversation(
      id: id ?? this.id,
      participantIds: participantIds ?? this.participantIds,
      messages: messages ?? this.messages,
      updatedAt: updatedAt ?? this.updatedAt,
      lastMessagePreview: lastMessagePreview ?? this.lastMessagePreview,
      artisanId: artisanId ?? this.artisanId,
      particularId: particularId ?? this.particularId,
    );
  }

  factory Conversation.fromJson(Map<String, dynamic> json) {
    final messagesJson = json['messages'] as List<dynamic>?;
    return Conversation(
      id: json['id'] as String,
      participantIds:
          (json['participantIds'] as List<dynamic>? ?? []).map((e) => e as String).toList(),
      artisanId: json['artisanId'] as String?,
      particularId: json['particularId'] as String?,
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? '') ?? DateTime.now(),
      lastMessagePreview: json['lastMessagePreview'] as String?,
      messages: messagesJson != null
          ? messagesJson
              .map((item) => Message.fromJson(item as Map<String, dynamic>))
              .toList()
          : const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participantIds': participantIds,
      'artisanId': artisanId,
      'particularId': particularId,
      'updatedAt': updatedAt.toIso8601String(),
      'lastMessagePreview': lastMessagePreview,
      'messages': messages.map((item) => item.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        participantIds,
        messages,
        updatedAt,
        lastMessagePreview,
        artisanId,
        particularId,
      ];
}
