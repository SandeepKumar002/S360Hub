class FinacExpenseClaimSummary {
  final String id;
  final String? orgId;
  final String? claimNumber;
  final String? claimantId;
  final String? entityId;
  final DateTime? claimDate;
  final double? totalTaxableAmount;
  final double? totalGstAmount;
  final double? totalTdsAmount;
  final double? totalAmount;
  final double? netPayableAmount;
  final String? reimbursementType;
  final String? paymentAccountId;
  final String? status;
  final DateTime? submittedAt;
  final DateTime? approvedAt;
  final String? approvedBy;
  final DateTime? paidAt;
  final String? paymentReference;
  final Map<String, dynamic>? policyViolations;
  final String? notes;
  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final DateTime? deletedAt;
  final String? deletedBy;
  final String? deleteType;
  final bool? isDeleted;

  FinacExpenseClaimSummary({
    required this.id,
    this.orgId,
    this.claimNumber,
    this.claimantId,
    this.entityId,
    this.claimDate,
    this.totalTaxableAmount,
    this.totalGstAmount,
    this.totalTdsAmount,
    this.totalAmount,
    this.netPayableAmount,
    this.reimbursementType,
    this.paymentAccountId,
    this.status,
    this.submittedAt,
    this.approvedAt,
    this.approvedBy,
    this.paidAt,
    this.paymentReference,
    this.policyViolations,
    this.notes,
    this.metadata,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    this.deletedBy,
    this.deleteType,
    this.isDeleted,
  });

  factory FinacExpenseClaimSummary.fromJson(Map<String, dynamic> json) {
    return FinacExpenseClaimSummary(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      claimNumber: json['claim_number'] as String?,
      claimantId: json['claimant_id'] as String?,
      entityId: json['entity_id'] as String?,
      claimDate: json['claim_date'] == null ? null : DateTime.parse(json['claim_date'] as String),
      totalTaxableAmount: (json['total_taxable_amount'] as num?)?.toDouble(),
      totalGstAmount: (json['total_gst_amount'] as num?)?.toDouble(),
      totalTdsAmount: (json['total_tds_amount'] as num?)?.toDouble(),
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
      netPayableAmount: (json['net_payable_amount'] as num?)?.toDouble(),
      reimbursementType: json['reimbursement_type'] as String?,
      paymentAccountId: json['payment_account_id'] as String?,
      status: json['status'] as String?,
      submittedAt: json['submitted_at'] == null ? null : DateTime.parse(json['submitted_at'] as String),
      approvedAt: json['approved_at'] == null ? null : DateTime.parse(json['approved_at'] as String),
      approvedBy: json['approved_by'] as String?,
      paidAt: json['paid_at'] == null ? null : DateTime.parse(json['paid_at'] as String),
      paymentReference: json['payment_reference'] as String?,
      policyViolations: json['policy_violations'] as Map<String, dynamic>? ?? {},
      notes: json['notes'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String?,
      updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at'] as String),
      updatedBy: json['updated_by'] as String?,
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
      'claim_number': claimNumber,
      'claimant_id': claimantId,
      'entity_id': entityId,
      'claim_date': claimDate?.toIso8601String(),
      'total_taxable_amount': totalTaxableAmount,
      'total_gst_amount': totalGstAmount,
      'total_tds_amount': totalTdsAmount,
      'total_amount': totalAmount,
      'net_payable_amount': netPayableAmount,
      'reimbursement_type': reimbursementType,
      'payment_account_id': paymentAccountId,
      'status': status,
      'submitted_at': submittedAt?.toIso8601String(),
      'approved_at': approvedAt?.toIso8601String(),
      'approved_by': approvedBy,
      'paid_at': paidAt?.toIso8601String(),
      'payment_reference': paymentReference,
      'policy_violations': policyViolations,
      'notes': notes,
      'metadata': metadata,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
      'updated_at': updatedAt?.toIso8601String(),
      'updated_by': updatedBy,
      'deleted_at': deletedAt?.toIso8601String(),
      'deleted_by': deletedBy,
      'delete_type': deleteType,
      'is_deleted': isDeleted,
    };
  }
}
