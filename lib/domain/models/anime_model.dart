class AnimeModel {
  String title, description, posterUrl, status, showType, ageRating;
  int episodeCount;

  AnimeModel(
      {required this.title,
      required this.description,
      required this.posterUrl,
      required this.episodeCount,
      required this.status,
      required this.ageRating,
      required this.showType
      });

  factory AnimeModel.fromJson(Map<String, dynamic> map) {
    return AnimeModel(
        title: map['attributes']['titles']['en_jp'],
        description: map['attributes']['description'],
        episodeCount : map['attributes']['episodeCount'],
        posterUrl: map['attributes']['posterImage']['tiny'],
        status:  map['attributes']['status'],
        ageRating: map['attributes']['ageRating'],
        showType: map['attributes']['showType']
        );

  }
}
