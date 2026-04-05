class CodeSnippet {
  String id;
  String title;
  String description;
  String language;
  String code;
  bool isFavorite;
  DateTime createdAt;
  DateTime? updatedAt;
  String? tags; // CSV format
  int? usageCount;

  CodeSnippet({
    required this.id,
    required this.title,
    required this.code,
    required this.language,
    this.description = '',
    this.isFavorite = false,
    DateTime? createdAt,
    this.updatedAt,
    this.tags,
    this.usageCount = 0,
  }) : createdAt = createdAt ?? DateTime.now();

  // Convert to JSON for Firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'language': language,
      'code': code,
      'isFavorite': isFavorite,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'tags': tags,
      'usageCount': usageCount,
    };
  }

  // Create from JSON
  factory CodeSnippet.fromJson(Map<String, dynamic> json) {
    return CodeSnippet(
      id: json['id'] ?? '',
      title: json['title'] ?? 'Untitled',
      description: json['description'] ?? '',
      language: json['language'] ?? 'Python',
      code: json['code'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
      createdAt: json['createdAt'] != null 
        ? DateTime.parse(json['createdAt']) 
        : DateTime.now(),
      updatedAt: json['updatedAt'] != null 
        ? DateTime.parse(json['updatedAt']) 
        : null,
      tags: json['tags'],
      usageCount: json['usageCount'] ?? 0,
    );
  }

  CodeSnippet copyWith({
    String? id,
    String? title,
    String? description,
    String? language,
    String? code,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? tags,
    int? usageCount,
  }) {
    return CodeSnippet(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      language: language ?? this.language,
      code: code ?? this.code,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tags: tags ?? this.tags,
      usageCount: usageCount ?? this.usageCount,
    );
  }
}
