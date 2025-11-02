import 'package:flutter/material.dart';

import '../models/artisan.dart';
import '../services/api/artisan_api_service.dart';
import '../widgets/artisan_card.dart';
import 'artisan_detail_screen.dart';

class ArtisanListScreen extends StatefulWidget {
  const ArtisanListScreen({super.key});

  static const routeName = '/artisans';

  @override
  State<ArtisanListScreen> createState() => _ArtisanListScreenState();
}

class _ArtisanListScreenState extends State<ArtisanListScreen> {
  final ArtisanApiService _artisanApiService = ArtisanApiService();

  late final ArtisanListArguments _args;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _args = ModalRoute.of(context)?.settings.arguments as ArtisanListArguments? ??
        const ArtisanListArguments(trade: '', city: '');
  }

  Future<List<Artisan>> _loadArtisans() {
    return _artisanApiService.fetchArtisans(trade: _args.trade, city: _args.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_args.trade.isEmpty ? 'Artisans' : 'Artisans - ${_args.trade}'),
            if (_args.city.isNotEmpty)
              Text(
                _args.city,
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
      ),
      body: FutureBuilder<List<Artisan>>(
        future: _loadArtisans(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  _formatError(snapshot.error),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final artisans = snapshot.data ?? const <Artisan>[];

          if (artisans.isEmpty) {
            return const Center(child: Text('Aucun artisan trouve.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: artisans.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final artisan = artisans[index];
              return ArtisanCard(
                artisan: artisan,
                onTap: () => Navigator.of(context).pushNamed(
                  ArtisanDetailScreen.routeName,
                  arguments: ArtisanDetailArguments(artisanId: artisan.id, artisan: artisan),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatError(Object? error) {
    if (error == null) {
      return 'Une erreur imprevue est survenue. Merci de reessayer.';
    }
    final text = error.toString();
    if (text.startsWith('Exception: ')) {
      return text.replaceFirst('Exception: ', '');
    }
    return text;
  }
}

class ArtisanListArguments {
  const ArtisanListArguments({required this.trade, required this.city});

  final String trade;
  final String city;
}
