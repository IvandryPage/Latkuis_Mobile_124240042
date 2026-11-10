import 'package:flutter/material.dart';
import 'package:latres_mobile_124240042/models/tv_show.dart';
import 'package:latres_mobile_124240042/services/tvmaze_service.dart';
import 'package:latres_mobile_124240042/widgets/tv_show_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
          itemBuilder: (context, index) => TvShowCard(show: shows[index]),
        );
      },
    );
  }
}
