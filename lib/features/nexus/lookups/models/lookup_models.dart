class LookupGroup {
  final String id;
  final String code;
  final String displayName;
  final String? description;
  final bool isActive;
  final DateTime? createdAt;
  final Map<String, dynamic> metadata;

  LookupGroup({
    required this.id,
    required this.code,
    required this.displayName,
    this.description,
    this.isActive = true,
    this.createdAt,
    this.metadata = const {},
  });

  factory LookupGroup.fromJson(Map<String, dynamic> json) {
    return LookupGroup(
      id: json['id'] as String,
      code: json['code'] as String? ?? '',
      displayName: json['display_name'] as String? ?? '',
      description: json['description'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'display_name': displayName,
      'description': description,
      'is_active': isActive,
      'metadata': metadata,
    };
  }
}

class LookupValue {
  final String id;
  final String groupId;
  final String key;
  final String value;
  final int sortOrder;
  final bool isActive;
  final DateTime? createdAt;
  final Map<String, dynamic> metadata;

  LookupValue({
    required this.id,
    required this.groupId,
    required this.key,
    required this.value,
    this.sortOrder = 0,
    this.isActive = true,
    this.createdAt,
    this.metadata = const {},
  });

  factory LookupValue.fromJson(Map<String, dynamic> json) {
    return LookupValue(
      id: json['id'] as String,
      groupId: json['group_id'] as String,
      key: json['key'] as String? ?? '',
      value: json['value'] as String? ?? '',
      sortOrder: json['sort_order'] as int? ?? 0,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': groupId,
      'key': key,
      'value': value,
      'sort_order': sortOrder,
      'is_active': isActive,
      'metadata': metadata,
    };
  }
}
