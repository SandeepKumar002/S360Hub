class ContracforceContractPayment {
  final String id;
  final String? orgId;
  final String? contractId;
  final String? paymentNumber;
  final String? invoiceNumber;
  final DateTime? invoiceDate;
  final DateTime? paymentPeriodStart;
  final DateTime? paymentPeriodEnd;
  final double? grossAmount;
  final Map<String, dynamic>? deductions;
  final double? netAmount;
  final double? gstAmount;
  final double? tdsAmount;
  final double? totalPayable;
  final DateTime? paymentDate;
  final String? paymentReference;
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

  ContracforceContractPayment({
    required this.id,
    this.orgId,
    this.contractId,
    this.paymentNumber,
    this.invoiceNumber,
    this.invoiceDate,
    this.paymentPeriodStart,
    this.paymentPeriodEnd,
    this.grossAmount,
    this.deductions,
    this.netAmount,
    this.gstAmount,
    this.tdsAmount,
    this.totalPayable,
    this.paymentDate,
    this.paymentReference,
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

  factory ContracforceContractPayment.fromJson(Map<String, dynamic> json) {
    return ContracforceContractPayment(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      contractId: json['contract_id'] as String?,
      paymentNumber: json['payment_number'] as String?,
      invoiceNumber: json['invoice_number'] as String?,
      invoiceDate: json['invoice_date'] == null ? null : DateTime.parse(json['invoice_date'] as String),
      paymentPeriodStart: json['payment_period_start'] == null ? null : DateTime.parse(json['payment_period_start'] as String),
      paymentPeriodEnd: json['payment_period_end'] == null ? null : DateTime.parse(json['payment_period_end'] as String),
      grossAmount: (json['gross_amount'] as num?)?.toDouble(),
      deductions: json['deductions'] as Map<String, dynamic>? ?? {},
      netAmount: (json['net_amount'] as num?)?.toDouble(),
      gstAmount: (json['gst_amount'] as num?)?.toDouble(),
      tdsAmount: (json['tds_amount'] as num?)?.toDouble(),
      totalPayable: (json['total_payable'] as num?)?.toDouble(),
      paymentDate: json['payment_date'] == null ? null : DateTime.parse(json['payment_date'] as String),
      paymentReference: json['payment_reference'] as String?,
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
      'contract_id': contractId,
      'payment_number': paymentNumber,
      'invoice_number': invoiceNumber,
      'invoice_date': invoiceDate?.toIso8601String(),
      'payment_period_start': paymentPeriodStart?.toIso8601String(),
      'payment_period_end': paymentPeriodEnd?.toIso8601String(),
      'gross_amount': grossAmount,
      'deductions': deductions,
      'net_amount': netAmount,
      'gst_amount': gstAmount,
      'tds_amount': tdsAmount,
      'total_payable': totalPayable,
      'payment_date': paymentDate?.toIso8601String(),
      'payment_reference': paymentReference,
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
