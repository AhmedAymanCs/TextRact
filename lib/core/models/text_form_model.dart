class TextFormModel {
  final String id;
  final String text;
  final String source;
  final DateTime createdAt;
  const TextFormModel({
    required this.text,
    required this.source,
    required this.createdAt,
    required this.id,
  });

  factory TextFormModel.fromjson(Map<String, dynamic> json) {
    return TextFormModel(
      text: json['text'] ?? 'Not Found',
      source: json['source'] ?? 'Not Found',
      createdAt: DateTime.parse(json['createdAt']),
      id: json['id'] ?? 'null',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'source': source,
      'createdAt': createdAt.toIso8601String(),
      'id': id,
    };
  }
}
