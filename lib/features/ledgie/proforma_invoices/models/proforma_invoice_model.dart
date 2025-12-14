class LedgieProformaInvoice {
  final String id;
  final String? orgId;
  final String? entityType;
  final String? proformaType;
  final String? serviceOrderId;
  final String? proposalId;
  final String? estimateId;
  final String? proformaNumber;
  final String? invoiceToName;
  final String? entityId;
  final String? entityCode;
  final String? contactName;
  final String? country;
  final String? state;
  final String? district;
  final String? subDistrict;
  final String? address;
  final String? pincode;
  final String? gstin;
  final String? pan;
  final String? paymentType;
  final int? paymentTermDays;
  final DateTime? invoiceDate;
  final DateTime? dueDate;
  final String? currency;
  final double? agreedValue;
  final double? invoiceValue;
  final double? tdsPercent;
  final double? tdsValue;
  final double? cgstPercent;
  final double? sgstPercent;
  final double? igstPercent;
  final double? cgstValue;
  final double? sgstValue;
  final double? igstValue;
  final double? totalValue;
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

  LedgieProformaInvoice({
    required this.id,
    this.orgId,
    this.entityType,
    this.proformaType,
    this.serviceOrderId,
    this.proposalId,
    this.estimateId,
    this.proformaNumber,
    this.invoiceToName,
    this.entityId,
    this.entityCode,
    this.contactName,
    this.country,
    this.state,
    this.district,
    this.subDistrict,
    this.address,
    this.pincode,
    this.gstin,
    this.pan,
    this.paymentType,
    this.paymentTermDays,
    this.invoiceDate,
    this.dueDate,
    this.currency,
    this.agreedValue,
    this.invoiceValue,
    this.tdsPercent,
    this.tdsValue,
    this.cgstPercent,
    this.sgstPercent,
    this.igstPercent,
    this.cgstValue,
    this.sgstValue,
    this.igstValue,
    this.totalValue,
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

  factory LedgieProformaInvoice.fromJson(Map<String, dynamic> json) {
    return LedgieProformaInvoice(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      entityType: json['entity_type'] as String?,
      proformaType: json['proforma_type'] as String?,
      serviceOrderId: json['service_order_id'] as String?,
      proposalId: json['proposal_id'] as String?,
      estimateId: json['estimate_id'] as String?,
      proformaNumber: json['proforma_number'] as String?,
      invoiceToName: json['invoice_to_name'] as String?,
      entityId: json['entity_id'] as String?,
      entityCode: json['entity_code'] as String?,
      contactName: json['contact_name'] as String?,
      country: json['country'] as String?,
      state: json['state'] as String?,
      district: json['district'] as String?,
      subDistrict: json['sub_district'] as String?,
      address: json['address'] as String?,
      pincode: json['pincode'] as String?,
      gstin: json['gstin'] as String?,
      pan: json['pan'] as String?,
      paymentType: json['payment_type'] as String?,
      paymentTermDays: json['payment_term_days'] as int?,
      invoiceDate: json['invoice_date'] == null ? null : DateTime.parse(json['invoice_date'] as String),
      dueDate: json['due_date'] == null ? null : DateTime.parse(json['due_date'] as String),
      currency: json['currency'] as String?,
      agreedValue: (json['agreed_value'] as num?)?.toDouble(),
      invoiceValue: (json['invoice_value'] as num?)?.toDouble(),
      tdsPercent: (json['tds_percent'] as num?)?.toDouble(),
      tdsValue: (json['tds_value'] as num?)?.toDouble(),
      cgstPercent: (json['cgst_percent'] as num?)?.toDouble(),
      sgstPercent: (json['sgst_percent'] as num?)?.toDouble(),
      igstPercent: (json['igst_percent'] as num?)?.toDouble(),
      cgstValue: (json['cgst_value'] as num?)?.toDouble(),
      sgstValue: (json['sgst_value'] as num?)?.toDouble(),
      igstValue: (json['igst_value'] as num?)?.toDouble(),
      totalValue: (json['total_value'] as num?)?.toDouble(),
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
      'entity_type': entityType,
      'proforma_type': proformaType,
      'service_order_id': serviceOrderId,
      'proposal_id': proposalId,
      'estimate_id': estimateId,
      'proforma_number': proformaNumber,
      'invoice_to_name': invoiceToName,
      'entity_id': entityId,
      'entity_code': entityCode,
      'contact_name': contactName,
      'country': country,
      'state': state,
      'district': district,
      'sub_district': subDistrict,
      'address': address,
      'pincode': pincode,
      'gstin': gstin,
      'pan': pan,
      'payment_type': paymentType,
      'payment_term_days': paymentTermDays,
      'invoice_date': invoiceDate?.toIso8601String(),
      'due_date': dueDate?.toIso8601String(),
      'currency': currency,
      'agreed_value': agreedValue,
      'invoice_value': invoiceValue,
      'tds_percent': tdsPercent,
      'tds_value': tdsValue,
      'cgst_percent': cgstPercent,
      'sgst_percent': sgstPercent,
      'igst_percent': igstPercent,
      'cgst_value': cgstValue,
      'sgst_value': sgstValue,
      'igst_value': igstValue,
      'total_value': totalValue,
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
