class ShieldPpeReturned {
  final String id;
  final String? orgId;
  final String? ppeIssuedId;
  final DateTime? returnDate;
  final int? quantityReturned;
  final String? condition;
  final String? returnedTo;
  final String? remarks;
  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final String? createdBy;

  ShieldPpeReturned({
    required this.id,
    this.orgId,
    this.ppeIssuedId,
    this.returnDate,
    this.quantityReturned,
    this.condition,
    this.returnedTo,
    this.remarks,
    this.metadata,
    this.createdAt,
    this.createdBy,
  });

  factory ShieldPpeReturned.fromJson(Map<String, dynamic> json) {
    return ShieldPpeReturned(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      ppeIssuedId: json['ppe_issued_id'] as String?,
      returnDate: json['return_date'] == null ? null : DateTime.parse(json['return_date'] as String),
      quantityReturned: json['quantity_returned'] as int?,
      condition: json['condition'] as String?,
      returnedTo: json['returned_to'] as String?,
      remarks: json['remarks'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'org_id': orgId,
      'ppe_issued_id': ppeIssuedId,
      'return_date': returnDate?.toIso8601String(),
      'quantity_returned': quantityReturned,
      'condition': condition,
      'returned_to': returnedTo,
      'remarks': remarks,
      'metadata': metadata,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
    };
  }
}
