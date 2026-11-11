import 'package:flutter/material.dart';
import 'package:flicksy/services/favorite_service.dart';
import 'package:flicksy/widgets/tv_show_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({required this.favoriteService, super.key});

  final FavoriteService favoriteService;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: favoriteService.listenable,
      builder: (context, box, child) {
        final favorites = favoriteService.getFavorites();
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
              favoriteService: favoriteService,
              onRemove: () async {
                await favoriteService.removeFavorite(show.id);
              },
            );
          },
        );
      },
    );
  }
}
