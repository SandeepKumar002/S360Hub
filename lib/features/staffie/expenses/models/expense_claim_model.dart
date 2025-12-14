class ExpenseClaim {
  final String id;
  final String claimNumber;
  final String employeeId;
  final DateTime claimDate;
  final double totalAmount;
  final String? status; // 'draft', 'submitted', 'approved', 'paid', 'rejected'
  final DateTime? submittedAt;
  final DateTime? approvedAt;
  
  ExpenseClaim({
    required this.id,
    required this.claimNumber,
    required this.employeeId,
    required this.claimDate,
    required this.totalAmount,
    this.status,
    this.submittedAt,
    this.approvedAt,
  });

  factory ExpenseClaim.fromJson(Map<String, dynamic> json) {
    return ExpenseClaim(
      id: json['id'] as String,
      claimNumber: json['claim_number'] as String? ?? '',
      employeeId: json['employee_id'] as String,
      claimDate: DateTime.parse(json['claim_date'] as String),
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String?,
      submittedAt: json['submitted_at'] == null ? null : DateTime.parse(json['submitted_at'] as String),
      approvedAt: json['approved_at'] == null ? null : DateTime.parse(json['approved_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'claim_number': claimNumber,
      'employee_id': employeeId,
      'claim_date': claimDate.toIso8601String().split('T')[0],
      'total_amount': totalAmount,
      'status': status,
      'submitted_at': submittedAt?.toIso8601String(),
      'approved_at': approvedAt?.toIso8601String(),
    };
  }
}
