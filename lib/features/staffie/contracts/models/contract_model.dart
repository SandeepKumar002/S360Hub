class EmploymentContract {
  final String id;
  final String employeeId;
  final String contractNumber;
  final String? type; // 'permanent', 'contract', 'probation'
  final DateTime? startDate;
  final DateTime? endDate;
  final double? contractValue; // Salary/CTC
  final bool autoRenew;
  final String? status; // 'active', 'expired', 'terminated'
  
  EmploymentContract({
    required this.id,
    required this.employeeId,
    required this.contractNumber,
    this.type,
    this.startDate,
    this.endDate,
    this.contractValue,
    this.autoRenew = false,
    this.status,
  });

  factory EmploymentContract.fromJson(Map<String, dynamic> json) {
    return EmploymentContract(
      id: json['id'] as String,
      employeeId: json['employee_id'] as String,
      contractNumber: json['contract_number'] as String? ?? '',
      type: json['contract_type'] as String?,
      startDate: json['start_date'] == null ? null : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null ? null : DateTime.parse(json['end_date'] as String),
      contractValue: (json['contract_value'] as num?)?.toDouble(),
      autoRenew: json['auto_renew'] as bool? ?? false,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'contract_number': contractNumber,
      'contract_type': type,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'contract_value': contractValue,
      'auto_renew': autoRenew,
      'status': status,
    };
  }
}
