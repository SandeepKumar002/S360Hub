class TaxforgeGstTransaction {
  final String id;
  final String? orgId;
  final String? referenceTable;
  final String? referenceId;
  final String? gstDetailId;
  final DateTime? transactionDate;
  final double? taxableAmount;
  final double? gstRatePercent;
  final String? gstType;
  final double? cgstAmount;
  final double? sgstAmount;
  final double? igstAmount;
  final double? cessAmount;
  final double? totalGstAmount;
  final bool? itcEligible;
  final bool? itcClaimed;
  final DateTime? invoiceDate;
  final String? filingPeriod;
  final String? documentRef;
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

  TaxforgeGstTransaction({
    required this.id,
    this.orgId,
    this.referenceTable,
    this.referenceId,
    this.gstDetailId,
    this.transactionDate,
    this.taxableAmount,
    this.gstRatePercent,
    this.gstType,
    this.cgstAmount,
    this.sgstAmount,
    this.igstAmount,
    this.cessAmount,
    this.totalGstAmount,
    this.itcEligible,
    this.itcClaimed,
    this.invoiceDate,
    this.filingPeriod,
    this.documentRef,
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

  factory TaxforgeGstTransaction.fromJson(Map<String, dynamic> json) {
    return TaxforgeGstTransaction(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      referenceTable: json['reference_table'] as String?,
      referenceId: json['reference_id'] as String?,
      gstDetailId: json['gst_detail_id'] as String?,
      transactionDate: json['transaction_date'] == null ? null : DateTime.parse(json['transaction_date'] as String),
      taxableAmount: (json['taxable_amount'] as num?)?.toDouble(),
      gstRatePercent: (json['gst_rate_percent'] as num?)?.toDouble(),
      gstType: json['gst_type'] as String?,
      cgstAmount: (json['cgst_amount'] as num?)?.toDouble(),
      sgstAmount: (json['sgst_amount'] as num?)?.toDouble(),
      igstAmount: (json['igst_amount'] as num?)?.toDouble(),
      cessAmount: (json['cess_amount'] as num?)?.toDouble(),
      totalGstAmount: (json['total_gst_amount'] as num?)?.toDouble(),
      itcEligible: json['itc_eligible'] as bool?,
      itcClaimed: json['itc_claimed'] as bool?,
      invoiceDate: json['invoice_date'] == null ? null : DateTime.parse(json['invoice_date'] as String),
      filingPeriod: json['filing_period'] as String?,
      documentRef: json['document_ref'] as String?,
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
      'gst_detail_id': gstDetailId,
      'transaction_date': transactionDate?.toIso8601String(),
      'taxable_amount': taxableAmount,
      'gst_rate_percent': gstRatePercent,
      'gst_type': gstType,
      'cgst_amount': cgstAmount,
      'sgst_amount': sgstAmount,
      'igst_amount': igstAmount,
      'cess_amount': cessAmount,
      'total_gst_amount': totalGstAmount,
      'itc_eligible': itcEligible,
      'itc_claimed': itcClaimed,
      'invoice_date': invoiceDate?.toIso8601String(),
      'filing_period': filingPeriod,
      'document_ref': documentRef,
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
