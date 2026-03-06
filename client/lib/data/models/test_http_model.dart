class TestHttpModel {
  final String randomWord;

  const TestHttpModel({required this.randomWord});

  factory TestHttpModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'word': String randomWord} => TestHttpModel(randomWord: randomWord),
      _ => throw FormatException('Invalid JSON format: $json'),
    };
  }

  static List<TestHttpModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => TestHttpModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}