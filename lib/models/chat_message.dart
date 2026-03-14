class ChatMessageModel {
  final String id;
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final String? codeBlock;
  final String? language;

  ChatMessageModel({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
    this.codeBlock,
    this.language,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] ?? '',
      content: json['content'] ?? '',
      isUser: json['is_user'] ?? false,
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      codeBlock: json['code_block'],
      language: json['language'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'is_user': isUser,
      'timestamp': timestamp.toIso8601String(),
      'code_block': codeBlock,
      'language': language,
    };
  }
}
