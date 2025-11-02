import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../models/artisan.dart';
import '../../models/realisation.dart';
import 'api_constants.dart';

class ArtisanApiService {
  const ArtisanApiService();

  /// Recuperer la liste des artisans en fonction du metier et de la ville.
  Future<List<Artisan>> fetchArtisans({required String trade, required String city}) async {
    assert(apiBaseUrl.isNotEmpty);

    final queryParameters = <String, String>{};
    if (trade.isNotEmpty) {
      queryParameters['metier'] = trade;
    }
    if (city.isNotEmpty) {
      queryParameters['ville'] = city;
    }

    final uri = Uri.parse('$apiBaseUrl/artisans').replace(
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );

    try {
      final response = await http.get(uri).timeout(defaultTimeout);
      if (response.statusCode != 200) {
        throw _buildHttpException(response);
      }

      final body = response.body;
      final decoded = jsonDecode(body);
      final items = _extractList(decoded);

      return items.map(Artisan.fromJson).toList();
    } on Object catch (error) {
      throw Exception(_resolveErrorMessage(error));
    }
  }

  /// Recuperer le detail d un artisan.
  Future<Artisan> fetchArtisanDetail(String artisanId) async {
    assert(apiBaseUrl.isNotEmpty);

    final uri = Uri.parse('$apiBaseUrl/artisans/$artisanId');

    try {
      final response = await http.get(uri).timeout(defaultTimeout);
      if (response.statusCode != 200) {
        throw _buildHttpException(response);
      }

      final decoded = jsonDecode(response.body);
      final map = _extractMap(decoded);

      return Artisan.fromJson(map);
    } on Object catch (error) {
      throw Exception(_resolveErrorMessage(error));
    }
  }

  /// Recuperer les realisations associees a un artisan.
  Future<List<Realisation>> fetchRealisations(String artisanId) async {
    assert(apiBaseUrl.isNotEmpty);

    final uri = Uri.parse('$apiBaseUrl/artisans/$artisanId/realisations');

    try {
      final response = await http.get(uri).timeout(defaultTimeout);
      if (response.statusCode != 200) {
        throw _buildHttpException(response);
      }

      final decoded = jsonDecode(response.body);
      final items = _extractList(decoded);

      return items.map(Realisation.fromJson).toList();
    } on Object catch (error) {
      throw Exception(_resolveErrorMessage(error));
    }
  }

  Exception _buildHttpException(http.Response response) {
    String message = 'Le serveur a renvoye une erreur (${response.statusCode}).';
    if (response.body.isNotEmpty) {
      try {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          final serverMessage = decoded['message'] ?? decoded['error'];
          if (serverMessage is String && serverMessage.trim().isNotEmpty) {
            message = serverMessage;
          }
        }
      } catch (_) {
        // Ignorer les erreurs de parsing et conserver le message generique.
      }
    }
    return Exception(message);
  }

  List<Map<String, dynamic>> _extractList(dynamic decoded) {
    if (decoded is List) {
      return decoded.cast<Map<String, dynamic>>();
    }

    if (decoded is Map<String, dynamic>) {
      final data = decoded['data'];
      if (data is List) {
        return data.cast<Map<String, dynamic>>();
      }
    }

    throw const FormatException('Format de reponse inattendu.');
  }

  Map<String, dynamic> _extractMap(dynamic decoded) {
    if (decoded is Map<String, dynamic>) {
      if (decoded['data'] is Map<String, dynamic>) {
        return decoded['data'] as Map<String, dynamic>;
      }
      return decoded;
    }

    throw const FormatException('Format de reponse inattendu.');
  }

  String _resolveErrorMessage(Object error) {
    if (error is Exception && error.toString().startsWith('Exception: ')) {
      return error.toString().replaceFirst('Exception: ', '');
    }
    if (error is TimeoutException) {
      return 'Le delai de reponse du serveur est depasse. Merci de reessayer.';
    }
    if (error is SocketException) {
      return 'Connexion internet indisponible. Verifiez votre reseau.';
    }
    if (error is http.ClientException) {
      return 'Erreur de communication avec le serveur.';
    }
    if (error is FormatException) {
      return 'Reponse du serveur invalide.';
    }
    return 'Une erreur imprevue est survenue. Merci de reessayer.';
  }
}
