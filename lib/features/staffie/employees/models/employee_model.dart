class Employee {
  final String id;
  final String? orgId;
  final String employeeCode;
  final String? personId;
  final String fullName;
  final String? designation; // Simplified for now, mapped from designation_id if needed or text
  final String? department; // Simplified
  final String? workEmail;
  final String? mobile;
  final DateTime? joiningDate;
  final String? status; // 'active', 'resigned', 'terminated'
  final Map<String, dynamic> metadata;
  // TODO: Add other fields like address, bank info as needed

  Employee({
    required this.id,
    this.orgId,
    required this.employeeCode,
    this.personId,
    required this.fullName,
    this.designation,
    this.department,
    this.workEmail,
    this.mobile,
    this.joiningDate,
    this.status,
    this.metadata = const {},
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      employeeCode: json['employee_code'] as String? ?? '',
      personId: json['person_id'] as String?,
      fullName: json['full_name'] as String? ?? 'Unknown',
      designation: json['designation'] as String?, // Assuming text, or join handle later
      department: json['department'] as String?,
      workEmail: json['work_email'] as String?,
      mobile: json['mobile'] as String?,
      joiningDate: json['joining_date'] == null ? null : DateTime.parse(json['joining_date'] as String),
      status: json['status'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'org_id': orgId,
      'employee_code': employeeCode,
      'person_id': personId,
      'full_name': fullName,
      'designation': designation,
      'department': department,
      'work_email': workEmail,
      'mobile': mobile,
      'joining_date': joiningDate?.toIso8601String(),
      'status': status,
      'metadata': metadata,
    };
  }
}
