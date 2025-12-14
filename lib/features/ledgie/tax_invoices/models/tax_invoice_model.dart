class LedgieTaxInvoice {
  final String id;
  final String? orgId;
  final String? proformaInvoiceId;
  final String? invoiceNumber;
  final DateTime? invoiceDate;
  final String? currency;
  final double? invoiceValue;
  final Map<String, dynamic>? taxBreakup;
  final double? totalValue;
  final double? amountPaid;
  final double? balanceDue;
  final String? remarks;
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

  LedgieTaxInvoice({
    required this.id,
    this.orgId,
    this.proformaInvoiceId,
    this.invoiceNumber,
    this.invoiceDate,
    this.currency,
    this.invoiceValue,
    this.taxBreakup,
    this.totalValue,
    this.amountPaid,
    this.balanceDue,
    this.remarks,
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

  factory LedgieTaxInvoice.fromJson(Map<String, dynamic> json) {
    return LedgieTaxInvoice(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      proformaInvoiceId: json['proforma_invoice_id'] as String?,
      invoiceNumber: json['invoice_number'] as String?,
      invoiceDate: json['invoice_date'] == null ? null : DateTime.parse(json['invoice_date'] as String),
      currency: json['currency'] as String?,
      invoiceValue: (json['invoice_value'] as num?)?.toDouble(),
      taxBreakup: json['tax_breakup'] as Map<String, dynamic>? ?? {},
      totalValue: (json['total_value'] as num?)?.toDouble(),
      amountPaid: (json['amount_paid'] as num?)?.toDouble(),
      balanceDue: (json['balance_due'] as num?)?.toDouble(),
      remarks: json['remarks'] as String?,
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
      'proforma_invoice_id': proformaInvoiceId,
      'invoice_number': invoiceNumber,
      'invoice_date': invoiceDate?.toIso8601String(),
      'currency': currency,
      'invoice_value': invoiceValue,
      'tax_breakup': taxBreakup,
      'total_value': totalValue,
      'amount_paid': amountPaid,
      'balance_due': balanceDue,
      'remarks': remarks,
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
