import 'package:flutter/material.dart';
import 'package:flicksy/models/tv_show.dart';
import 'package:flicksy/services/favorite_service.dart';
import 'package:flicksy/services/tvmaze_service.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    required this.showId,
    required this.favoriteService,
    super.key,
  });

  final int showId;
  final FavoriteService favoriteService;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TvmazeService _tvmazeService = TvmazeService();
  late Future<TvShow> _show;

  @override
  void initState() {
    super.initState();
    _show = _tvmazeService.fetchShow(widget.showId);
  }

  void _retry() {
    setState(() {
      _show = _tvmazeService.fetchShow(widget.showId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail TV Show')),
      body: FutureBuilder<TvShow>(
        future: _show,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Gagal memuat detail: ${snapshot.error}'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _retry,
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            );
          }

          final show = snapshot.requireData;
          return ValueListenableBuilder(
            valueListenable: widget.favoriteService.listenable,
            builder: (context, box, child) {
              final isFavorite = widget.favoriteService.isFavorite(show.id);
              return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (show.imageUrl case final imageUrl?)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    height: 360,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const _ImagePlaceholder(),
                  ),
                )
              else
                const _ImagePlaceholder(),
              const SizedBox(height: 16),
              Text(
                show.name,
                style: Theme.of(context).textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  tooltip: isFavorite
                      ? 'Hapus dari favorit'
                      : 'Tambahkan ke favorit',
                  onPressed: () async {
                    if (isFavorite) {
                      await widget.favoriteService.removeFavorite(show.id);
                    } else {
                      await widget.favoriteService.addFavorite(show);
                    }
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(show.rating?.toStringAsFixed(1) ?? 'Belum ada rating'),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                show.genres.isEmpty
                    ? 'Genre tidak tersedia'
                    : show.genres.join(' • '),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Text(
                'Overview',
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                show.summary.isEmpty
                    ? 'Ringkasan tidak tersedia.'
                    : show.summary,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          );
            },
          );
        },
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.movie_outlined, size: 48),
    );
  }
}
