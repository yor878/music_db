class Song {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String genre;
  final int releaseYear;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.genre,
    required this.releaseYear,
  });

  // Copiar objeto para modificaciones seguras
  Song copyWith({
    String? id,
    String? title,
    String? artist,
    String? album,
    String? genre,
    int? releaseYear,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      genre: genre ?? this.genre,
      releaseYear: releaseYear ?? this.releaseYear,
    );
  }
}
