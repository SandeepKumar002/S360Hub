class FinacExpenseClaimDetail {
  final String id;
  final String? claimId;
  final int? lineNumber;
  final DateTime? expenseDate;
  final String? category;
  final String? subCategory;
  final String? description;
  final String? supplierName;
  final String? supplierGstin;
  final String? supplierPan;
  final String? invoiceNumber;
  final DateTime? invoiceDate;
  final double? taxableAmount;
  final double? gstRatePercent;
  final String? gstType;
  final double? cgstAmount;
  final double? sgstAmount;
  final double? igstAmount;
  final double? cessAmount;
  final double? totalLineAmount;
  final bool? tdsApplicable;
  final String? tdsSection;
  final double? tdsRatePercent;
  final double? tdsAmount;
  final bool? reimbursable;
  final String? costCenter;
  final String? projectCode;
  final String? hsnSacId;
  final Map<String, dynamic>? attachments;
  final Map<String, dynamic>? complianceFlags;
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

  FinacExpenseClaimDetail({
    required this.id,
    this.claimId,
    this.lineNumber,
    this.expenseDate,
    this.category,
    this.subCategory,
    this.description,
    this.supplierName,
    this.supplierGstin,
    this.supplierPan,
    this.invoiceNumber,
    this.invoiceDate,
    this.taxableAmount,
    this.gstRatePercent,
    this.gstType,
    this.cgstAmount,
    this.sgstAmount,
    this.igstAmount,
    this.cessAmount,
    this.totalLineAmount,
    this.tdsApplicable,
    this.tdsSection,
    this.tdsRatePercent,
    this.tdsAmount,
    this.reimbursable,
    this.costCenter,
    this.projectCode,
    this.hsnSacId,
    this.attachments,
    this.complianceFlags,
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

  factory FinacExpenseClaimDetail.fromJson(Map<String, dynamic> json) {
    return FinacExpenseClaimDetail(
      id: json['id'] as String,
      claimId: json['claim_id'] as String?,
      lineNumber: json['line_number'] as int?,
      expenseDate: json['expense_date'] == null ? null : DateTime.parse(json['expense_date'] as String),
      category: json['category'] as String?,
      subCategory: json['sub_category'] as String?,
      description: json['description'] as String?,
      supplierName: json['supplier_name'] as String?,
      supplierGstin: json['supplier_gstin'] as String?,
      supplierPan: json['supplier_pan'] as String?,
      invoiceNumber: json['invoice_number'] as String?,
      invoiceDate: json['invoice_date'] == null ? null : DateTime.parse(json['invoice_date'] as String),
      taxableAmount: (json['taxable_amount'] as num?)?.toDouble(),
      gstRatePercent: (json['gst_rate_percent'] as num?)?.toDouble(),
      gstType: json['gst_type'] as String?,
      cgstAmount: (json['cgst_amount'] as num?)?.toDouble(),
      sgstAmount: (json['sgst_amount'] as num?)?.toDouble(),
      igstAmount: (json['igst_amount'] as num?)?.toDouble(),
      cessAmount: (json['cess_amount'] as num?)?.toDouble(),
      totalLineAmount: (json['total_line_amount'] as num?)?.toDouble(),
      tdsApplicable: json['tds_applicable'] as bool?,
      tdsSection: json['tds_section'] as String?,
      tdsRatePercent: (json['tds_rate_percent'] as num?)?.toDouble(),
      tdsAmount: (json['tds_amount'] as num?)?.toDouble(),
      reimbursable: json['reimbursable'] as bool?,
      costCenter: json['cost_center'] as String?,
      projectCode: json['project_code'] as String?,
      hsnSacId: json['hsn_sac_id'] as String?,
      attachments: json['attachments'] as Map<String, dynamic>? ?? {},
      complianceFlags: json['compliance_flags'] as Map<String, dynamic>? ?? {},
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
      'claim_id': claimId,
      'line_number': lineNumber,
      'expense_date': expenseDate?.toIso8601String(),
      'category': category,
      'sub_category': subCategory,
      'description': description,
      'supplier_name': supplierName,
      'supplier_gstin': supplierGstin,
      'supplier_pan': supplierPan,
      'invoice_number': invoiceNumber,
      'invoice_date': invoiceDate?.toIso8601String(),
      'taxable_amount': taxableAmount,
      'gst_rate_percent': gstRatePercent,
      'gst_type': gstType,
      'cgst_amount': cgstAmount,
      'sgst_amount': sgstAmount,
      'igst_amount': igstAmount,
      'cess_amount': cessAmount,
      'total_line_amount': totalLineAmount,
      'tds_applicable': tdsApplicable,
      'tds_section': tdsSection,
      'tds_rate_percent': tdsRatePercent,
      'tds_amount': tdsAmount,
      'reimbursable': reimbursable,
      'cost_center': costCenter,
      'project_code': projectCode,
      'hsn_sac_id': hsnSacId,
      'attachments': attachments,
      'compliance_flags': complianceFlags,
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
