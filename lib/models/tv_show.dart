class TvShow {
  const TvShow({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.genres,
    required this.summary,
  });

  final int id;
  final String name;
  final String? imageUrl;
  final double? rating;
  final List<String> genres;
  final String summary;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': imageUrl == null ? null : {'medium': imageUrl},
      'rating': {'average': rating},
      'genres': genres,
      'summary': summary,
    };
  }

  factory TvShow.fromJson(Map<String, dynamic> json) {
    final image = json['image'];
    final imageUrl = image is Map ? image['medium'] : null;
    final rating = json['rating'];
    final ratingValue = rating is Map ? rating['average'] : null;

    return TvShow(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? 'Tanpa judul',
      imageUrl: imageUrl is String ? imageUrl : null,
      rating: ratingValue is num ? ratingValue.toDouble() : null,
      genres: (json['genres'] as List<dynamic>? ?? const [])
          .whereType<String>()
          .toList(),
      summary: _plainText(json['summary'] as String? ?? ''),
    );
  }

  static String _plainText(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&nbsp;', ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }
}
