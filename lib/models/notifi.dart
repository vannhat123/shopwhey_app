
class Notifi {
  int  id;
  String url, title;

  Notifi({
    required this.id,
    required this.url,
    required this.title
  });

  factory Notifi.fromJson(Map<String, dynamic> json) {
    return Notifi(
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['thumbnailUrl'] as String,
    );
  }
}