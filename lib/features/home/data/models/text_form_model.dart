class TextFormModel {
  final String text;
  final String source;
  final DateTime createdAt;
  const TextFormModel({
    required this.text,
    required this.source,
    required this.createdAt,
  });

  factory TextFormModel.fromjson(Map<String, dynamic> json) {
    return TextFormModel(
      text: json['text'] ?? 'Not Found',
      source: json['source'] ?? 'Not Found',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'source': source,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
