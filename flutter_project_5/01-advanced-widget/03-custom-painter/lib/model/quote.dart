class Quote {
  final String id;
  final String quote;
  final String author;

  const Quote({required this.id, required this.quote, required this.author});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'] as String,
      quote: json['en'] as String,
      author: json['author'] as String,
    );
  }

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      id: map['id'] as String,
      quote: map['en'] as String,
      author: map['author'] as String,
    );
  }
}
