class LedgieEstimate {
  final String id;
  final String? orgId;
  final String? proposalId;
  final String? estimateNumber;
  final DateTime? estimateDate;
  final String? entityId;
  final String? entityCode;
  final String? entityName;
  final String? entityContactName;
  final String? country;
  final String? state;
  final String? district;
  final String? subDistrict;
  final String? address;
  final String? pincode;
  final String? gstin;
  final String? pan;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? sector;
  final Map<String, dynamic>? hsnSacCodes;
  final String? serviceType;
  final int? quoteValidityDays;
  final String? serviceDescription;
  final int? numberOfUnits;
  final String? currency;
  final double? estimatedCosts;
  final double? paymentRetainerPct;
  final double? retainerValue;
  final double? balancePct;
  final double? balanceValue;
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
  final String? leadsProspectId;

  LedgieEstimate({
    required this.id,
    this.orgId,
    this.proposalId,
    this.estimateNumber,
    this.estimateDate,
    this.entityId,
    this.entityCode,
    this.entityName,
    this.entityContactName,
    this.country,
    this.state,
    this.district,
    this.subDistrict,
    this.address,
    this.pincode,
    this.gstin,
    this.pan,
    this.startDate,
    this.endDate,
    this.sector,
    this.hsnSacCodes,
    this.serviceType,
    this.quoteValidityDays,
    this.serviceDescription,
    this.numberOfUnits,
    this.currency,
    this.estimatedCosts,
    this.paymentRetainerPct,
    this.retainerValue,
    this.balancePct,
    this.balanceValue,
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
    this.leadsProspectId,
  });

  factory LedgieEstimate.fromJson(Map<String, dynamic> json) {
    return LedgieEstimate(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      proposalId: json['proposal_id'] as String?,
      estimateNumber: json['estimate_number'] as String?,
      estimateDate: json['estimate_date'] == null ? null : DateTime.parse(json['estimate_date'] as String),
      entityId: json['entity_id'] as String?,
      entityCode: json['entity_code'] as String?,
      entityName: json['entity_name'] as String?,
      entityContactName: json['entity_contact_name'] as String?,
      country: json['country'] as String?,
      state: json['state'] as String?,
      district: json['district'] as String?,
      subDistrict: json['sub_district'] as String?,
      address: json['address'] as String?,
      pincode: json['pincode'] as String?,
      gstin: json['gstin'] as String?,
      pan: json['pan'] as String?,
      startDate: json['start_date'] == null ? null : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null ? null : DateTime.parse(json['end_date'] as String),
      sector: json['sector'] as String?,
      hsnSacCodes: json['hsn_sac_codes'] as Map<String, dynamic>? ?? {},
      serviceType: json['service_type'] as String?,
      quoteValidityDays: json['quote_validity_days'] as int?,
      serviceDescription: json['service_description'] as String?,
      numberOfUnits: json['number_of_units'] as int?,
      currency: json['currency'] as String?,
      estimatedCosts: (json['estimated_costs'] as num?)?.toDouble(),
      paymentRetainerPct: (json['payment_retainer_pct'] as num?)?.toDouble(),
      retainerValue: (json['retainer_value'] as num?)?.toDouble(),
      balancePct: (json['balance_pct'] as num?)?.toDouble(),
      balanceValue: (json['balance_value'] as num?)?.toDouble(),
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
      leadsProspectId: json['leads_prospect_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'org_id': orgId,
      'proposal_id': proposalId,
      'estimate_number': estimateNumber,
      'estimate_date': estimateDate?.toIso8601String(),
      'entity_id': entityId,
      'entity_code': entityCode,
      'entity_name': entityName,
      'entity_contact_name': entityContactName,
      'country': country,
      'state': state,
      'district': district,
      'sub_district': subDistrict,
      'address': address,
      'pincode': pincode,
      'gstin': gstin,
      'pan': pan,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'sector': sector,
      'hsn_sac_codes': hsnSacCodes,
      'service_type': serviceType,
      'quote_validity_days': quoteValidityDays,
      'service_description': serviceDescription,
      'number_of_units': numberOfUnits,
      'currency': currency,
      'estimated_costs': estimatedCosts,
      'payment_retainer_pct': paymentRetainerPct,
      'retainer_value': retainerValue,
      'balance_pct': balancePct,
      'balance_value': balanceValue,
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
      'leads_prospect_id': leadsProspectId,
    };
  }
}
