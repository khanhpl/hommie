class ImageList {
  int id;
  String image;

  ImageList({
    required this.id,
    required this.image,
  });

  factory ImageList.fromJson(Map<String, dynamic> json) => ImageList(
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}
