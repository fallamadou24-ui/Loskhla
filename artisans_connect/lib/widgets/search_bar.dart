import 'package:flutter/material.dart';

class ArtisanSearchBar extends StatelessWidget {
  const ArtisanSearchBar({
    super.key,
    this.onSearch,
  });

  final void Function(String metier, String ville)? onSearch;

  @override
  Widget build(BuildContext context) {
    final jobController = TextEditingController();
    final cityController = TextEditingController();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: jobController,
              decoration: const InputDecoration(
                labelText: 'Metiers (menuisier, electricien...)',
                prefixIcon: Icon(Icons.handyman_outlined),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: 'Ville ou code postal',
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => onSearch?.call(
                jobController.text.trim(),
                cityController.text.trim(),
              ),
              icon: const Icon(Icons.search),
              label: const Text('Rechercher'),
            ),
          ],
        ),
      ),
    );
  }
}
