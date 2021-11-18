List<News> listNewsFromJson(Map<String,dynamic> response) {
  final data = response["data"];
  return new List<News>.from(data.map((x) => News.fromJson(x)));
}


class News{
  int id;
  String title;
  String short_description;
  String content;
  String created_at;
  String image;
  String slug;

  News({
    this.id,
    this.title,
    this.short_description,
    this.created_at,
    this.content,
    this.image,
    this.slug
  });

  factory News.fromJson(Map<String,dynamic>json)=>News(
    id: json["id"],
    title: json["title"],
    short_description: json["short_description"],
    content:json["content"],
    created_at: json["created_at"],
    image: json["image"],
    slug: json["slug"]
  );
}