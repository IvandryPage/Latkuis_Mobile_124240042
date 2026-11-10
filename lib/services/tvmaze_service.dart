import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latres_mobile_124240042/models/tv_show.dart';

class TvmazeService {
  static final Uri _showsUri = Uri.https('api.tvmaze.com', '/shows');

  Future<List<TvShow>> fetchShows() async {
    final response = await http
        .get(_showsUri)
        .timeout(const Duration(seconds: 20));

    if (response.statusCode != 200) {
      throw Exception('Gagal memuat data TVmaze (${response.statusCode}).');
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! List) {
      throw const FormatException('Format data TVmaze tidak sesuai.');
    }

    return decoded.map((item) {
      if (item is! Map<String, dynamic>) {
        throw const FormatException(
          'Data TVmaze berisi item yang tidak valid.',
        );
      }
      return TvShow.fromJson(item);
    }).toList();
  }
}
