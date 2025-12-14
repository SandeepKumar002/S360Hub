class TaxforgeTdsTransaction {
  final String id;
  final String? orgId;
  final String? referenceTable;
  final String? referenceId;
  final String? tdsDetailId;
  final DateTime? transactionDate;
  final double? baseAmount;
  final double? tdsRatePercent;
  final double? tdsAmount;
  final DateTime? depositedDate;
  final String? challanNo;
  final String? deductedBy;
  final bool? itcApplicability;
  final String? acknowledgementNumber;
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

  TaxforgeTdsTransaction({
    required this.id,
    this.orgId,
    this.referenceTable,
    this.referenceId,
    this.tdsDetailId,
    this.transactionDate,
    this.baseAmount,
    this.tdsRatePercent,
    this.tdsAmount,
    this.depositedDate,
    this.challanNo,
    this.deductedBy,
    this.itcApplicability,
    this.acknowledgementNumber,
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

  factory TaxforgeTdsTransaction.fromJson(Map<String, dynamic> json) {
    return TaxforgeTdsTransaction(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      referenceTable: json['reference_table'] as String?,
      referenceId: json['reference_id'] as String?,
      tdsDetailId: json['tds_detail_id'] as String?,
      transactionDate: json['transaction_date'] == null ? null : DateTime.parse(json['transaction_date'] as String),
      baseAmount: (json['base_amount'] as num?)?.toDouble(),
      tdsRatePercent: (json['tds_rate_percent'] as num?)?.toDouble(),
      tdsAmount: (json['tds_amount'] as num?)?.toDouble(),
      depositedDate: json['deposited_date'] == null ? null : DateTime.parse(json['deposited_date'] as String),
      challanNo: json['challan_no'] as String?,
      deductedBy: json['deducted_by'] as String?,
      itcApplicability: json['itc_applicability'] as bool?,
      acknowledgementNumber: json['acknowledgement_number'] as String?,
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
      'reference_table': referenceTable,
      'reference_id': referenceId,
      'tds_detail_id': tdsDetailId,
      'transaction_date': transactionDate?.toIso8601String(),
      'base_amount': baseAmount,
      'tds_rate_percent': tdsRatePercent,
      'tds_amount': tdsAmount,
      'deposited_date': depositedDate?.toIso8601String(),
      'challan_no': challanNo,
      'deducted_by': deductedBy,
      'itc_applicability': itcApplicability,
      'acknowledgement_number': acknowledgementNumber,
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
