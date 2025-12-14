class CommLogHistory {
  final String id;
  final String? orgId;
  final String? schemaName;
  final String? tableName;
  final String? recordId;
  final String? operation;
  final String? changedBy;
  final String? changedById;
  final DateTime? changedAt;
  final Map<String, dynamic>? oldData;
  final Map<String, dynamic>? newData;
  final String? comment;
  final Map<String, dynamic>? metadata;
  final String? changedFields;
  final String? ipAddress;
  final String? userAgent;
  final String? sessionId;
  final String? requestId;

  CommLogHistory({
    required this.id,
    this.orgId,
    this.schemaName,
    this.tableName,
    this.recordId,
    this.operation,
    this.changedBy,
    this.changedById,
    this.changedAt,
    this.oldData,
    this.newData,
    this.comment,
    this.metadata,
    this.changedFields,
    this.ipAddress,
    this.userAgent,
    this.sessionId,
    this.requestId,
  });

  factory CommLogHistory.fromJson(Map<String, dynamic> json) {
    return CommLogHistory(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      schemaName: json['schema_name'] as String?,
      tableName: json['table_name'] as String?,
      recordId: json['record_id'] as String?,
      operation: json['operation'] as String?,
      changedBy: json['changed_by'] as String?,
      changedById: json['changed_by_id'] as String?,
      changedAt: json['changed_at'] == null ? null : DateTime.parse(json['changed_at'] as String),
      oldData: json['old_data'] as Map<String, dynamic>? ?? {},
      newData: json['new_data'] as Map<String, dynamic>? ?? {},
      comment: json['comment'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      changedFields: json['changed_fields'] as String?,
      ipAddress: json['ip_address'] as String?,
      userAgent: json['user_agent'] as String?,
      sessionId: json['session_id'] as String?,
      requestId: json['request_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'org_id': orgId,
      'schema_name': schemaName,
      'table_name': tableName,
      'record_id': recordId,
      'operation': operation,
      'changed_by': changedBy,
      'changed_by_id': changedById,
      'changed_at': changedAt?.toIso8601String(),
      'old_data': oldData,
      'new_data': newData,
      'comment': comment,
      'metadata': metadata,
      'changed_fields': changedFields,
      'ip_address': ipAddress,
      'user_agent': userAgent,
      'session_id': sessionId,
      'request_id': requestId,
    };
  }
}
