import '../../models/artisan.dart';
import '../../models/realisation.dart';
import 'api_constants.dart';

class ArtisanApiService {
  const ArtisanApiService();

  /// Recuperer la liste des artisans en fonction du metier et de la ville.
  Future<List<Artisan>> fetchArtisans({required String trade, required String city}) async {
    assert(apiBaseUrl.isNotEmpty);
    // TODO: Implement API call using apiBaseUrl
    return Future.value(const []);
  }

  /// Recuperer le detail d un artisan.
  Future<Artisan> fetchArtisanDetail(String artisanId) async {
    assert(apiBaseUrl.isNotEmpty);
    // TODO: Implement API call using apiBaseUrl
    return Future.value(
      Artisan(
        id: artisanId,
        name: 'Artisan demo',
        trade: 'Menuisier',
        city: 'Paris',
        rating: 4.5,
        description: 'Description a remplacer',
        portfolio: const [],
      ),
    );
  }

  /// Recuperer les realisations associees a un artisan.
  Future<List<Realisation>> fetchRealisations(String artisanId) async {
    assert(apiBaseUrl.isNotEmpty);
    // TODO: Implement API call using apiBaseUrl
    return Future.value(const []);
  }
}
