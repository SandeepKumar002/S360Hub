class FinacBankTransaction {
  final String id;
  final String? orgId;
  final String? transactionNumber;
  final String? bankAccountId;
  final DateTime? txnDate;
  final double? amount;
  final String? currency;
  final double? currencyRate;
  final String? direction;
  final String? transactionPurpose;
  final String? partyType;
  final String? partyId;
  final String? referenceTable;
  final String? referenceId;
  final String? bankReference;
  final String? chequeNumber;
  final String? utrNumber;
  final String? status;
  final DateTime? clearedAt;
  final String? reconciliationStatus;
  final DateTime? reconciledAt;
  final String? reconciledBy;
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

  FinacBankTransaction({
    required this.id,
    this.orgId,
    this.transactionNumber,
    this.bankAccountId,
    this.txnDate,
    this.amount,
    this.currency,
    this.currencyRate,
    this.direction,
    this.transactionPurpose,
    this.partyType,
    this.partyId,
    this.referenceTable,
    this.referenceId,
    this.bankReference,
    this.chequeNumber,
    this.utrNumber,
    this.status,
    this.clearedAt,
    this.reconciliationStatus,
    this.reconciledAt,
    this.reconciledBy,
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

  factory FinacBankTransaction.fromJson(Map<String, dynamic> json) {
    return FinacBankTransaction(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      transactionNumber: json['transaction_number'] as String?,
      bankAccountId: json['bank_account_id'] as String?,
      txnDate: json['txn_date'] == null ? null : DateTime.parse(json['txn_date'] as String),
      amount: (json['amount'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      currencyRate: (json['currency_rate'] as num?)?.toDouble(),
      direction: json['direction'] as String?,
      transactionPurpose: json['transaction_purpose'] as String?,
      partyType: json['party_type'] as String?,
      partyId: json['party_id'] as String?,
      referenceTable: json['reference_table'] as String?,
      referenceId: json['reference_id'] as String?,
      bankReference: json['bank_reference'] as String?,
      chequeNumber: json['cheque_number'] as String?,
      utrNumber: json['utr_number'] as String?,
      status: json['status'] as String?,
      clearedAt: json['cleared_at'] == null ? null : DateTime.parse(json['cleared_at'] as String),
      reconciliationStatus: json['reconciliation_status'] as String?,
      reconciledAt: json['reconciled_at'] == null ? null : DateTime.parse(json['reconciled_at'] as String),
      reconciledBy: json['reconciled_by'] as String?,
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
      'transaction_number': transactionNumber,
      'bank_account_id': bankAccountId,
      'txn_date': txnDate?.toIso8601String(),
      'amount': amount,
      'currency': currency,
      'currency_rate': currencyRate,
      'direction': direction,
      'transaction_purpose': transactionPurpose,
      'party_type': partyType,
      'party_id': partyId,
      'reference_table': referenceTable,
      'reference_id': referenceId,
      'bank_reference': bankReference,
      'cheque_number': chequeNumber,
      'utr_number': utrNumber,
      'status': status,
      'cleared_at': clearedAt?.toIso8601String(),
      'reconciliation_status': reconciliationStatus,
      'reconciled_at': reconciledAt?.toIso8601String(),
      'reconciled_by': reconciledBy,
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
