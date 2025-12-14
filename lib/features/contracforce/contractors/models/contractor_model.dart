class ContracforceContractor {
  final String id;
  final String? orgId;
  final String? entityId;
  final String? contractorCode;
  final String? contractorName;
  final String? contractorType;
  final String? contactPerson;
  final String? contactNumber;
  final String? email;
  final String? address;
  final String? city;
  final String? state;
  final String? pincode;
  final String? gstNumber;
  final String? panNumber;
  final String? bankName;
  final String? bankAccountNumberMasked;
  final String? ifscCode;
  final String? licenseNumber;
  final DateTime? licenseExpiryDate;
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

  ContracforceContractor({
    required this.id,
    this.orgId,
    this.entityId,
    this.contractorCode,
    this.contractorName,
    this.contractorType,
    this.contactPerson,
    this.contactNumber,
    this.email,
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.gstNumber,
    this.panNumber,
    this.bankName,
    this.bankAccountNumberMasked,
    this.ifscCode,
    this.licenseNumber,
    this.licenseExpiryDate,
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

  factory ContracforceContractor.fromJson(Map<String, dynamic> json) {
    return ContracforceContractor(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      entityId: json['entity_id'] as String?,
      contractorCode: json['contractor_code'] as String?,
      contractorName: json['contractor_name'] as String?,
      contractorType: json['contractor_type'] as String?,
      contactPerson: json['contact_person'] as String?,
      contactNumber: json['contact_number'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      pincode: json['pincode'] as String?,
      gstNumber: json['gst_number'] as String?,
      panNumber: json['pan_number'] as String?,
      bankName: json['bank_name'] as String?,
      bankAccountNumberMasked: json['bank_account_number_masked'] as String?,
      ifscCode: json['ifsc_code'] as String?,
      licenseNumber: json['license_number'] as String?,
      licenseExpiryDate: json['license_expiry_date'] == null ? null : DateTime.parse(json['license_expiry_date'] as String),
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
      'entity_id': entityId,
      'contractor_code': contractorCode,
      'contractor_name': contractorName,
      'contractor_type': contractorType,
      'contact_person': contactPerson,
      'contact_number': contactNumber,
      'email': email,
      'address': address,
      'city': city,
      'state': state,
      'pincode': pincode,
      'gst_number': gstNumber,
      'pan_number': panNumber,
      'bank_name': bankName,
      'bank_account_number_masked': bankAccountNumberMasked,
      'ifsc_code': ifscCode,
      'license_number': licenseNumber,
      'license_expiry_date': licenseExpiryDate?.toIso8601String(),
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
