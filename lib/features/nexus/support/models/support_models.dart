class NexusFile {
  final String id;
  final String fileName;
  final String fileUrl;
  final String? fileType;
  final int fileSize;
  final DateTime? createdAt;
  final Map<String, dynamic> metadata;

  NexusFile({
    required this.id,
    required this.fileName,
    required this.fileUrl,
    this.fileType,
    this.fileSize = 0,
    this.createdAt,
    this.metadata = const {},
  });

  factory NexusFile.fromJson(Map<String, dynamic> json) {
    return NexusFile(
      id: json['id'] as String,
      fileName: json['file_name'] as String? ?? 'Unnamed',
      fileUrl: json['file_url'] as String? ?? '',
      fileType: json['file_type'] as String?,
      fileSize: json['file_size'] as int? ?? 0,
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );
  }
}

class Comment {
  final String id;
  final String content;
  final String? userId; // Author
  final String? parentId; // Threading
  final DateTime? createdAt;
  
  Comment({
    required this.id,
    required this.content,
    this.userId,
    this.parentId,
    this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String,
      content: json['content'] as String? ?? '',
      userId: json['created_by'] as String?,
      parentId: json['parent_id'] as String?,
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
    );
  }
}
