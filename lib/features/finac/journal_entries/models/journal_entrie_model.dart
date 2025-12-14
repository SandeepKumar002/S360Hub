class FinacJournalEntrie {
  final String id;
  final String? orgId;
  final String? journalNumber;
  final DateTime? journalDate;
  final String? entryType;
  final String? referenceTable;
  final String? referenceId;
  final String? description;
  final double? totalDebit;
  final double? totalCredit;
  final String? status;
  final DateTime? postedAt;
  final String? postedBy;
  final bool? reversed;
  final String? reversedById;
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

  FinacJournalEntrie({
    required this.id,
    this.orgId,
    this.journalNumber,
    this.journalDate,
    this.entryType,
    this.referenceTable,
    this.referenceId,
    this.description,
    this.totalDebit,
    this.totalCredit,
    this.status,
    this.postedAt,
    this.postedBy,
    this.reversed,
    this.reversedById,
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

  factory FinacJournalEntrie.fromJson(Map<String, dynamic> json) {
    return FinacJournalEntrie(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      journalNumber: json['journal_number'] as String?,
      journalDate: json['journal_date'] == null ? null : DateTime.parse(json['journal_date'] as String),
      entryType: json['entry_type'] as String?,
      referenceTable: json['reference_table'] as String?,
      referenceId: json['reference_id'] as String?,
      description: json['description'] as String?,
      totalDebit: (json['total_debit'] as num?)?.toDouble(),
      totalCredit: (json['total_credit'] as num?)?.toDouble(),
      status: json['status'] as String?,
      postedAt: json['posted_at'] == null ? null : DateTime.parse(json['posted_at'] as String),
      postedBy: json['posted_by'] as String?,
      reversed: json['reversed'] as bool?,
      reversedById: json['reversed_by_id'] as String?,
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
      'journal_number': journalNumber,
      'journal_date': journalDate?.toIso8601String(),
      'entry_type': entryType,
      'reference_table': referenceTable,
      'reference_id': referenceId,
      'description': description,
      'total_debit': totalDebit,
      'total_credit': totalCredit,
      'status': status,
      'posted_at': postedAt?.toIso8601String(),
      'posted_by': postedBy,
      'reversed': reversed,
      'reversed_by_id': reversedById,
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
