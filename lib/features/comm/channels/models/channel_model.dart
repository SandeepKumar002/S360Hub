class CommChannel {
  final String id;
  final String? orgId;
  final String? name;
  final String? type;
  final DateTime? createdAt;
  final String? createdBy;

  CommChannel({
    required this.id,
    this.orgId,
    this.name,
    this.type,
    this.createdAt,
    this.createdBy,
  });

  factory CommChannel.fromJson(Map<String, dynamic> json) {
    return CommChannel(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'org_id': orgId,
      'name': name,
      'type': type,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
    };
  }
}
