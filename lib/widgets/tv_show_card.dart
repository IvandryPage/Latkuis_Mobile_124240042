import 'package:flutter/material.dart';
import 'package:latres_mobile_124240042/models/tv_show.dart';
import 'package:latres_mobile_124240042/views/detail_screen.dart';

class TvShowCard extends StatelessWidget {
  const TvShowCard({required this.show, super.key});

  final TvShow show;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => DetailScreen(showId: show.id),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              SizedBox(
                width: 96,
                height: 136,
                child: show.imageUrl == null
                    ? const _ImagePlaceholder()
                    : Image.network(
                        show.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const _ImagePlaceholder(),
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      show.name,
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 18, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(show.rating?.toStringAsFixed(1) ?? '-'),
                      ],
                    ),
                    if (show.genres.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        show.genres.join(' • '),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.12),
      child: const Icon(Icons.movie_outlined, size: 36),
    );
  }
}
