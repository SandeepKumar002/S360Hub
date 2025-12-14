class SurveySurvey {
  final String id;
  final String? orgId;
  final String? title;
  final String? description;
  final String? surveyType;
  final bool? isActive;
  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final String? createdBy;

  SurveySurvey({
    required this.id,
    this.orgId,
    this.title,
    this.description,
    this.surveyType,
    this.isActive,
    this.metadata,
    this.createdAt,
    this.createdBy,
  });

  factory SurveySurvey.fromJson(Map<String, dynamic> json) {
    return SurveySurvey(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      surveyType: json['survey_type'] as String?,
      isActive: json['is_active'] as bool?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'org_id': orgId,
      'title': title,
      'description': description,
      'survey_type': surveyType,
      'is_active': isActive,
      'metadata': metadata,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
    };
  }
}
