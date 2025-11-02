import 'api_constants.dart';

class ProfileApiService {
  const ProfileApiService();

  /// Recuperer les informations du profil de l utilisateur courant.
  Future<Map<String, dynamic>> fetchProfile() async {
    assert(apiBaseUrl.isNotEmpty);
    // TODO: Implement API call using apiBaseUrl
    return Future.value({
      'name': 'Utilisateur Demo',
      'email': 'utilisateur@example.com',
      'phone': '+33000000000',
    });
  }

  /// Mettre a jour les informations du profil.
  Future<void> updateProfile(Map<String, dynamic> payload) async {
    assert(apiBaseUrl.isNotEmpty);
    // TODO: Implement API call using apiBaseUrl
    return Future.value();
  }
}
