class ContracforceContractorStaff {
  final String id;
  final String? orgId;
  final String? contractorId;
  final String? staffCode;
  final String? fullName;
  final String? fatherName;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? mobile;
  final String? address;
  final String? staffType;
  final DateTime? joiningDate;
  final DateTime? leavingDate;
  final String? aadhaarNumberMasked;
  final String? bankAccountNumberMasked;
  final String? ifscCode;
  final String? uanNumber;
  final String? esiNumber;
  final double? wagePerDay;
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

  ContracforceContractorStaff({
    required this.id,
    this.orgId,
    this.contractorId,
    this.staffCode,
    this.fullName,
    this.fatherName,
    this.dateOfBirth,
    this.gender,
    this.mobile,
    this.address,
    this.staffType,
    this.joiningDate,
    this.leavingDate,
    this.aadhaarNumberMasked,
    this.bankAccountNumberMasked,
    this.ifscCode,
    this.uanNumber,
    this.esiNumber,
    this.wagePerDay,
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

  factory ContracforceContractorStaff.fromJson(Map<String, dynamic> json) {
    return ContracforceContractorStaff(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      contractorId: json['contractor_id'] as String?,
      staffCode: json['staff_code'] as String?,
      fullName: json['full_name'] as String?,
      fatherName: json['father_name'] as String?,
      dateOfBirth: json['date_of_birth'] == null ? null : DateTime.parse(json['date_of_birth'] as String),
      gender: json['gender'] as String?,
      mobile: json['mobile'] as String?,
      address: json['address'] as String?,
      staffType: json['staff_type'] as String?,
      joiningDate: json['joining_date'] == null ? null : DateTime.parse(json['joining_date'] as String),
      leavingDate: json['leaving_date'] == null ? null : DateTime.parse(json['leaving_date'] as String),
      aadhaarNumberMasked: json['aadhaar_number_masked'] as String?,
      bankAccountNumberMasked: json['bank_account_number_masked'] as String?,
      ifscCode: json['ifsc_code'] as String?,
      uanNumber: json['uan_number'] as String?,
      esiNumber: json['esi_number'] as String?,
      wagePerDay: (json['wage_per_day'] as num?)?.toDouble(),
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
      'contractor_id': contractorId,
      'staff_code': staffCode,
      'full_name': fullName,
      'father_name': fatherName,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'mobile': mobile,
      'address': address,
      'staff_type': staffType,
      'joining_date': joiningDate?.toIso8601String(),
      'leaving_date': leavingDate?.toIso8601String(),
      'aadhaar_number_masked': aadhaarNumberMasked,
      'bank_account_number_masked': bankAccountNumberMasked,
      'ifsc_code': ifscCode,
      'uan_number': uanNumber,
      'esi_number': esiNumber,
      'wage_per_day': wagePerDay,
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
