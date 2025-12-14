class ShieldMedicalExamination {
  final String id;
  final String? orgId;
  final String? employeeId;
  final String? examinationType;
  final DateTime? examinationDate;
  final String? medicalCenter;
  final String? doctorName;
  final String? fitnessStatus;
  final String? restrictions;
  final DateTime? validUntil;
  final String? certificateFileId;
  final String? remarks;
  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final DateTime? approvedAt;
  final String? approvedBy;
  final DateTime? deletedAt;
  final String? deletedBy;
  final String? deleteType;
  final bool? isDeleted;

  ShieldMedicalExamination({
    required this.id,
    this.orgId,
    this.employeeId,
    this.examinationType,
    this.examinationDate,
    this.medicalCenter,
    this.doctorName,
    this.fitnessStatus,
    this.restrictions,
    this.validUntil,
    this.certificateFileId,
    this.remarks,
    this.metadata,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.approvedAt,
    this.approvedBy,
    this.deletedAt,
    this.deletedBy,
    this.deleteType,
    this.isDeleted,
  });

  factory ShieldMedicalExamination.fromJson(Map<String, dynamic> json) {
    return ShieldMedicalExamination(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      employeeId: json['employee_id'] as String?,
      examinationType: json['examination_type'] as String?,
      examinationDate: json['examination_date'] == null ? null : DateTime.parse(json['examination_date'] as String),
      medicalCenter: json['medical_center'] as String?,
      doctorName: json['doctor_name'] as String?,
      fitnessStatus: json['fitness_status'] as String?,
      restrictions: json['restrictions'] as String?,
      validUntil: json['valid_until'] == null ? null : DateTime.parse(json['valid_until'] as String),
      certificateFileId: json['certificate_file_id'] as String?,
      remarks: json['remarks'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String?,
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
      'org_id': orgId,
      'employee_id': employeeId,
      'examination_type': examinationType,
      'examination_date': examinationDate?.toIso8601String(),
      'medical_center': medicalCenter,
      'doctor_name': doctorName,
      'fitness_status': fitnessStatus,
      'restrictions': restrictions,
      'valid_until': validUntil?.toIso8601String(),
      'certificate_file_id': certificateFileId,
      'remarks': remarks,
      'metadata': metadata,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
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
