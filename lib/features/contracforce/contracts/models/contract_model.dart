class ContracforceContract {
  final String id;
  final String? orgId;
  final String? contractorId;
  final String? contractNumber;
  final String? contractType;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? scopeOfWork;
  final double? contractValue;
  final String? paymentTerms;
  final bool? autoRenew;
  final String? contractFileId;
  final String? status;
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

  ContracforceContract({
    required this.id,
    this.orgId,
    this.contractorId,
    this.contractNumber,
    this.contractType,
    this.startDate,
    this.endDate,
    this.scopeOfWork,
    this.contractValue,
    this.paymentTerms,
    this.autoRenew,
    this.contractFileId,
    this.status,
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

  factory ContracforceContract.fromJson(Map<String, dynamic> json) {
    return ContracforceContract(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      contractorId: json['contractor_id'] as String?,
      contractNumber: json['contract_number'] as String?,
      contractType: json['contract_type'] as String?,
      startDate: json['start_date'] == null ? null : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null ? null : DateTime.parse(json['end_date'] as String),
      scopeOfWork: json['scope_of_work'] as String?,
      contractValue: (json['contract_value'] as num?)?.toDouble(),
      paymentTerms: json['payment_terms'] as String?,
      autoRenew: json['auto_renew'] as bool?,
      contractFileId: json['contract_file_id'] as String?,
      status: json['status'] as String?,
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
      'contractor_id': contractorId,
      'contract_number': contractNumber,
      'contract_type': contractType,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'scope_of_work': scopeOfWork,
      'contract_value': contractValue,
      'payment_terms': paymentTerms,
      'auto_renew': autoRenew,
      'contract_file_id': contractFileId,
      'status': status,
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
