import 'package:flutter/material.dart';
import 'package:flicksy/models/tv_show.dart';
import 'package:flicksy/services/favorite_service.dart';
import 'package:flicksy/services/tvmaze_service.dart';
import 'package:flicksy/widgets/tv_show_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.favoriteService, super.key});

  final FavoriteService favoriteService;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TvmazeService _tvmazeService = TvmazeService();
  late final Future<List<TvShow>> _shows;

  @override
  void initState() {
    super.initState();
    _shows = _tvmazeService.fetchShows();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TvShow>>(
      future: _shows,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const SizedBox.shrink();
        }

        final shows = snapshot.data ?? const <TvShow>[];
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: shows.length,
          itemBuilder: (context, index) => TvShowCard(
            show: shows[index],
            favoriteService: widget.favoriteService,
          ),
        );
      },
    );
  }
}
