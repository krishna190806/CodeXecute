class CodeExecution {
  String id;
  String code;
  String language;
  String output;
  String? errorMessage;
  int executionTimeMs;
  DateTime executedAt;
  String? stdinData;
  bool isSuccess;

  CodeExecution({
    required this.id,
    required this.code,
    required this.language,
    required this.output,
    this.errorMessage,
    required this.executionTimeMs,
    DateTime? executedAt,
    this.stdinData,
    required this.isSuccess,
  }) : executedAt = executedAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'language': language,
      'output': output,
      'errorMessage': errorMessage,
      'executionTimeMs': executionTimeMs,
      'executedAt': executedAt.toIso8601String(),
      'stdinData': stdinData,
      'isSuccess': isSuccess,
    };
  }

  factory CodeExecution.fromJson(Map<String, dynamic> json) {
    return CodeExecution(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      language: json['language'] ?? 'Python',
      output: json['output'] ?? '',
      errorMessage: json['errorMessage'],
      executionTimeMs: json['executionTimeMs'] ?? 0,
      executedAt: json['executedAt'] != null 
        ? DateTime.parse(json['executedAt']) 
        : DateTime.now(),
      stdinData: json['stdinData'],
      isSuccess: json['isSuccess'] ?? false,
    );
  }
}
