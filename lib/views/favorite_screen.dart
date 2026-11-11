import 'package:flutter/material.dart';
import 'package:latres_mobile_124240042/services/favorite_repository.dart';
import 'package:latres_mobile_124240042/widgets/tv_show_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: FavoriteRepository.listenable,
      builder: (context, box, child) {
        final favorites = FavoriteRepository.getAll();
        if (favorites.isEmpty) {
          return const Center(child: Text('Belum ada TV show favorit.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final show = favorites[index];
            return TvShowCard(
              show: show,
              onRemove: () async {
                await FavoriteRepository.remove(show.id);
              },
            );
          },
        );
      },
    );
  }
}
