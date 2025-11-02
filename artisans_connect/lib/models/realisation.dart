import 'package:equatable/equatable.dart';

enum RealisationType { photo, video }

class Realisation extends Equatable {
  const Realisation({
    required this.id,
    required this.artisanId,
    required this.title,
    required this.description,
    required this.mediaUrl,
    required this.type,
    required this.createdAt,
  });

  final String id;
  final String artisanId;
  final String title;
  final String description;
  final String mediaUrl;
  final RealisationType type;
  final DateTime createdAt;

  Realisation copyWith({
    String? id,
    String? artisanId,
    String? title,
    String? description,
    String? mediaUrl,
    RealisationType? type,
    DateTime? createdAt,
  }) {
    return Realisation(
      id: id ?? this.id,
      artisanId: artisanId ?? this.artisanId,
      title: title ?? this.title,
      description: description ?? this.description,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Realisation.fromJson(Map<String, dynamic> json) {
    return Realisation(
      id: json['id'] as String,
      artisanId: json['artisanId'] as String,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      mediaUrl: json['mediaUrl'] as String,
      type: RealisationType.values.firstWhere(
        (value) => value.name == (json['type'] as String? ?? 'photo'),
        orElse: () => RealisationType.photo,
      ),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'artisanId': artisanId,
      'title': title,
      'description': description,
      'mediaUrl': mediaUrl,
      'type': type.name,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, artisanId, title, description, mediaUrl, type, createdAt];
}
