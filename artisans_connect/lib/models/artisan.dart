import 'package:equatable/equatable.dart';

import 'realisation.dart';

class Artisan extends Equatable {
  const Artisan({
    required this.id,
    required this.name,
    required this.trade,
    required this.city,
    required this.rating,
    required this.description,
    required this.portfolio,
    this.coverImageUrl,
    this.phone,
    this.email,
    this.website,
  });

  final String id;
  final String name;
  final String trade;
  final String city;
  final double rating;
  final String description;
  final List<Realisation> portfolio;
  final String? coverImageUrl;
  final String? phone;
  final String? email;
  final String? website;

  Artisan copyWith({
    String? id,
    String? name,
    String? trade,
    String? city,
    double? rating,
    String? description,
    List<Realisation>? portfolio,
    String? coverImageUrl,
    String? phone,
    String? email,
    String? website,
  }) {
    return Artisan(
      id: id ?? this.id,
      name: name ?? this.name,
      trade: trade ?? this.trade,
      city: city ?? this.city,
      rating: rating ?? this.rating,
      description: description ?? this.description,
      portfolio: portfolio ?? this.portfolio,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      website: website ?? this.website,
    );
  }

  factory Artisan.fromJson(Map<String, dynamic> json) {
    final portfolioJson = json['portfolio'] as List<dynamic>?;
    return Artisan(
      id: json['id'] as String,
      name: json['name'] as String,
      trade: json['trade'] as String,
      city: json['city'] as String,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      description: json['description'] as String? ?? '',
      portfolio: portfolioJson != null
          ? portfolioJson
              .map((item) => Realisation.fromJson(item as Map<String, dynamic>))
              .toList()
          : const [],
      coverImageUrl: json['coverImageUrl'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      website: json['website'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'trade': trade,
      'city': city,
      'rating': rating,
      'description': description,
      'portfolio': portfolio.map((item) => item.toJson()).toList(),
      'coverImageUrl': coverImageUrl,
      'phone': phone,
      'email': email,
      'website': website,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        trade,
        city,
        rating,
        description,
        portfolio,
        coverImageUrl,
        phone,
        email,
        website,
      ];
}
