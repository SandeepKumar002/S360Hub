class SurveySurveyResponse {
  final String id;
  final String? surveyId;
  final String? respondentId;
  final DateTime? submittedAt;
  final Map<String, dynamic>? answers;
  final double? score;
  final Map<String, dynamic>? metadata;
  final String? orgId;
  final DateTime? updatedAt;
  final String? updatedBy;
  final DateTime? approvedAt;
  final String? approvedBy;
  final DateTime? deletedAt;
  final String? deletedBy;
  final String? deleteType;
  final bool? isDeleted;

  SurveySurveyResponse({
    required this.id,
    this.surveyId,
    this.respondentId,
    this.submittedAt,
    this.answers,
    this.score,
    this.metadata,
    this.orgId,
    this.updatedAt,
    this.updatedBy,
    this.approvedAt,
    this.approvedBy,
    this.deletedAt,
    this.deletedBy,
    this.deleteType,
    this.isDeleted,
  });

  factory SurveySurveyResponse.fromJson(Map<String, dynamic> json) {
    return SurveySurveyResponse(
      id: json['id'] as String,
      surveyId: json['survey_id'] as String?,
      respondentId: json['respondent_id'] as String?,
      submittedAt: json['submitted_at'] == null ? null : DateTime.parse(json['submitted_at'] as String),
      answers: json['answers'] as Map<String, dynamic>? ?? {},
      score: (json['score'] as num?)?.toDouble(),
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      orgId: json['org_id'] as String?,
      updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at'] as String),
      updatedBy: json['updated_by'] as String?,
      approvedAt: json['approved_at'] == null ? null : DateTime.parse(json['approved_at'] as String),
      approvedBy: json['approved_by'] as String?,
      deletedAt: json['deleted_at'] == null ? null : DateTime.parse(json['deleted_at'] as String),
      deletedBy: json['deleted_by'] as String?,
      deleteType: json['delete_type'] as String?,
      isDeleted: json['is_deleted'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'survey_id': surveyId,
      'respondent_id': respondentId,
      'submitted_at': submittedAt?.toIso8601String(),
      'answers': answers,
      'score': score,
      'metadata': metadata,
      'org_id': orgId,
      'updated_at': updatedAt?.toIso8601String(),
      'updated_by': updatedBy,
      'approved_at': approvedAt?.toIso8601String(),
      'approved_by': approvedBy,
      'deleted_at': deletedAt?.toIso8601String(),
      'deleted_by': deletedBy,
      'delete_type': deleteType,
      'is_deleted': isDeleted,
    };
  }
}
