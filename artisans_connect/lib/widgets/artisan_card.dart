import 'package:flutter/material.dart';

import '../models/artisan.dart';

class ArtisanCard extends StatelessWidget {
  const ArtisanCard({
    super.key,
    required this.artisan,
    this.onTap,
  });

  final Artisan artisan;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: artisan.coverImageUrl != null
                  ? Ink.image(
                      image: NetworkImage(artisan.coverImageUrl!),
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.orange.shade50,
                      child: const Icon(Icons.handyman, size: 40),
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      artisan.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(artisan.trade, style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 4),
                    Text(artisan.city, style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(artisan.rating.toStringAsFixed(1)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
