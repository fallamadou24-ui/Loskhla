import 'package:flutter/material.dart';

import '../widgets/search_bar.dart';
import 'artisan_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  void _onSearch(BuildContext context, String trade, String city) {
    Navigator.of(context).pushNamed(
      ArtisanListScreen.routeName,
      arguments: ArtisanListArguments(trade: trade, city: city),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artisans Connect'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/profile'),
            icon: const Icon(Icons.person),
            tooltip: 'Mon profil',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trouvez le bon artisan pres de chez vous',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ArtisanSearchBar(
              onSearch: (trade, city) => _onSearch(context, trade, city),
            ),
            const SizedBox(height: 32),
            Text(
              'Metiers populaires',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                _PopularTradeChip(label: 'Menuisier'),
                _PopularTradeChip(label: 'Plombier'),
                _PopularTradeChip(label: 'Electricien'),
                _PopularTradeChip(label: 'Macon'),
                _PopularTradeChip(label: 'Peintre'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PopularTradeChip extends StatelessWidget {
  const _PopularTradeChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      onPressed: () => Navigator.of(context).pushNamed(
        ArtisanListScreen.routeName,
        arguments: ArtisanListArguments(trade: label, city: ''),
      ),
    );
  }
}
