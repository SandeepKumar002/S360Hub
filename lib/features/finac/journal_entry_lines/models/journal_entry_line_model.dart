class FinacJournalEntryLine {
  final String id;
  final String? journalEntryId;
  final int? lineNumber;
  final String? accountCode;
  final String? accountName;
  final double? debitAmount;
  final double? creditAmount;
  final String? description;
  final String? costCenter;
  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;

  FinacJournalEntryLine({
    required this.id,
    this.journalEntryId,
    this.lineNumber,
    this.accountCode,
    this.accountName,
    this.debitAmount,
    this.creditAmount,
    this.description,
    this.costCenter,
    this.metadata,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
  });

  factory FinacJournalEntryLine.fromJson(Map<String, dynamic> json) {
    return FinacJournalEntryLine(
      id: json['id'] as String,
      journalEntryId: json['journal_entry_id'] as String?,
      lineNumber: json['line_number'] as int?,
      accountCode: json['account_code'] as String?,
      accountName: json['account_name'] as String?,
      debitAmount: (json['debit_amount'] as num?)?.toDouble(),
      creditAmount: (json['credit_amount'] as num?)?.toDouble(),
      description: json['description'] as String?,
      costCenter: json['cost_center'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String?,
      updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at'] as String),
      updatedBy: json['updated_by'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'journal_entry_id': journalEntryId,
      'line_number': lineNumber,
      'account_code': accountCode,
      'account_name': accountName,
      'debit_amount': debitAmount,
      'credit_amount': creditAmount,
      'description': description,
      'cost_center': costCenter,
      'metadata': metadata,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
      'updated_at': updatedAt?.toIso8601String(),
      'updated_by': updatedBy,
    };
  }
}
