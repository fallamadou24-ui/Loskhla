import 'package:flutter/material.dart';

import '../models/artisan.dart';
import '../models/realisation.dart';
import '../services/api/artisan_api_service.dart';
import '../widgets/realisation_gallery.dart';

class ArtisanDetailScreen extends StatefulWidget {
  const ArtisanDetailScreen({super.key});

  static const routeName = '/artisans/detail';

  @override
  State<ArtisanDetailScreen> createState() => _ArtisanDetailScreenState();
}

class _ArtisanDetailScreenState extends State<ArtisanDetailScreen> {
  final ArtisanApiService _artisanApiService = ArtisanApiService();

  late final ArtisanDetailArguments _args;
  Artisan? _artisan;
  List<Realisation> _realisations = const [];
  bool _initialized = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) {
      return;
    }
    _initialized = true;

    _args = ModalRoute.of(context)?.settings.arguments as ArtisanDetailArguments? ??
        const ArtisanDetailArguments(artisanId: '');
    _artisan = _args.artisan;

    if (_artisan == null) {
      _isLoading = true;
    }

    _fetchData();
  }

  Future<void> _fetchData() async {
    final artisanId = _args.artisanId;
    if (artisanId.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Identifiant artisan manquant.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final artisan = await _artisanApiService.fetchArtisanDetail(artisanId);
      final realisations = await _artisanApiService.fetchRealisations(artisanId);

      if (!mounted) {
        return;
      }

      setState(() {
        _artisan = artisan;
        _realisations = realisations;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      final message = _formatError(error);
      setState(() {
        _errorMessage = message;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final artisan = _artisan;

    Widget body;

    if (artisan == null) {
      if (_errorMessage != null) {
        body = Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              _errorMessage!,
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        body = const Center(child: CircularProgressIndicator());
      }
    } else {
      body = Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundImage:
                          artisan.coverImageUrl != null ? NetworkImage(artisan.coverImageUrl!) : null,
                      child: artisan.coverImageUrl == null
                          ? const Icon(Icons.person_outline, size: 36)
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            artisan.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(artisan.trade, style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 16),
                              const SizedBox(width: 4),
                              Text(artisan.city),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text(artisan.rating.toStringAsFixed(1)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text('A propos', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(artisan.description.isEmpty
                    ? 'Description non disponible.'
                    : artisan.description),
                const SizedBox(height: 24),
                if (artisan.phone != null)
                  ListTile(
                    leading: const Icon(Icons.call_outlined),
                    title: Text(artisan.phone!),
                  ),
                if (artisan.email != null)
                  ListTile(
                    leading: const Icon(Icons.mail_outline),
                    title: Text(artisan.email!),
                  ),
                if (artisan.website != null)
                  ListTile(
                    leading: const Icon(Icons.link),
                    title: Text(artisan.website!),
                  ),
                const SizedBox(height: 16),
                Text('Realisations', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                RealisationGallery(items: _realisations),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () {
                    // TODO: Navigate to messaging flow
                  },
                  icon: const Icon(Icons.forum_outlined),
                  label: const Text('Contacter'),
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Text(
                      _errorMessage!,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Theme.of(context).colorScheme.error),
                    ),
                  ),
              ],
            ),
          ),
          if (_isLoading)
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(),
            ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(artisan?.name ?? 'Artisan'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement share feature
            },
            icon: const Icon(Icons.share_outlined),
          ),
        ],
      ),
      body: body,
    );
  }

  String _formatError(Object error) {
    final text = error.toString();
    if (text.startsWith('Exception: ')) {
      return text.replaceFirst('Exception: ', '');
    }
    return text;
  }
}

class ArtisanDetailArguments {
  const ArtisanDetailArguments({required this.artisanId, this.artisan});

  final String artisanId;
  final Artisan? artisan;
}
