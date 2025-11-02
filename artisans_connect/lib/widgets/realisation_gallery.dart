import 'package:flutter/material.dart';

import '../models/realisation.dart';

class RealisationGallery extends StatelessWidget {
  const RealisationGallery({
    super.key,
    required this.items,
  });

  final List<Realisation> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('Aucune realisation pour le moment.'));
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(item.mediaUrl, fit: BoxFit.cover),
              if (item.type == RealisationType.video)
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.play_arrow, color: Colors.white),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
