class TvShow {
  final int ?id;
  final String? name;
  final String ?imageThumbnailPath;
  final String ?network;
  final String ?status;

  TvShow({
    required this.id,
    required this.name,
    required this.imageThumbnailPath,
    required this.network,
    required this.status,
  });

  factory TvShow.fromJson(Map<String, dynamic> json) {
    return TvShow(
      id: json['id']??'',
      name: json['name']??'',
      imageThumbnailPath: json['image_thumbnail_path']??'',
      network: json['network']??'',
      status: json['status']??'',
    );
  }
}
