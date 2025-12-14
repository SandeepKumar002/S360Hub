class KnowledgeDoc {
  final String id;
  final String? orgId;
  final String? title;
  final String? slug;
  final Map<String, dynamic>? content;
  final String? docType;
  final String? status;
  final String? tags;
  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;

  KnowledgeDoc({
    required this.id,
    this.orgId,
    this.title,
    this.slug,
    this.content,
    this.docType,
    this.status,
    this.tags,
    this.metadata,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
  });

  factory KnowledgeDoc.fromJson(Map<String, dynamic> json) {
    return KnowledgeDoc(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      content: json['content'] as Map<String, dynamic>? ?? {},
      docType: json['doc_type'] as String?,
      status: json['status'] as String?,
      tags: json['tags'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String?,
      updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at'] as String),
      updatedBy: json['updated_by'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'org_id': orgId,
      'title': title,
      'slug': slug,
      'content': content,
      'doc_type': docType,
      'status': status,
      'tags': tags,
      'metadata': metadata,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
      'updated_at': updatedAt?.toIso8601String(),
      'updated_by': updatedBy,
    };
  }
}
