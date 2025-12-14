class FinacBankAccount {
  final String id;
  final String? orgId;
  final String? partyType;
  final String? partyId;
  final String? accountHolderName;
  final String? bankName;
  final String? branchName;
  final String? accountNumberMasked;
  final String? accountNumberEncrypted;
  final String? ifscCode;
  final String? swiftCode;
  final String? accountType;
  final String? currency;
  final double? openingBalance;
  final double? currentBalance;
  final bool? isDefault;
  final bool? verified;
  final Map<String, dynamic>? kycDocuments;
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

  FinacBankAccount({
    required this.id,
    this.orgId,
    this.partyType,
    this.partyId,
    this.accountHolderName,
    this.bankName,
    this.branchName,
    this.accountNumberMasked,
    this.accountNumberEncrypted,
    this.ifscCode,
    this.swiftCode,
    this.accountType,
    this.currency,
    this.openingBalance,
    this.currentBalance,
    this.isDefault,
    this.verified,
    this.kycDocuments,
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

  factory FinacBankAccount.fromJson(Map<String, dynamic> json) {
    return FinacBankAccount(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      partyType: json['party_type'] as String?,
      partyId: json['party_id'] as String?,
      accountHolderName: json['account_holder_name'] as String?,
      bankName: json['bank_name'] as String?,
      branchName: json['branch_name'] as String?,
      accountNumberMasked: json['account_number_masked'] as String?,
      accountNumberEncrypted: json['account_number_encrypted'] as String?,
      ifscCode: json['ifsc_code'] as String?,
      swiftCode: json['swift_code'] as String?,
      accountType: json['account_type'] as String?,
      currency: json['currency'] as String?,
      openingBalance: (json['opening_balance'] as num?)?.toDouble(),
      currentBalance: (json['current_balance'] as num?)?.toDouble(),
      isDefault: json['is_default'] as bool?,
      verified: json['verified'] as bool?,
      kycDocuments: json['kyc_documents'] as Map<String, dynamic>? ?? {},
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
      'party_type': partyType,
      'party_id': partyId,
      'account_holder_name': accountHolderName,
      'bank_name': bankName,
      'branch_name': branchName,
      'account_number_masked': accountNumberMasked,
      'account_number_encrypted': accountNumberEncrypted,
      'ifsc_code': ifscCode,
      'swift_code': swiftCode,
      'account_type': accountType,
      'currency': currency,
      'opening_balance': openingBalance,
      'current_balance': currentBalance,
      'is_default': isDefault,
      'verified': verified,
      'kyc_documents': kycDocuments,
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
