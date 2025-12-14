class AttendanceLog {
  final String id;
  final String employeeId;
  final DateTime date;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final String? status; // 'present', 'absent', 'leave', 'half_day'
  final double? workingHours;
  final String? remarks;

  AttendanceLog({
    required this.id,
    required this.employeeId,
    required this.date,
    this.checkInTime,
    this.checkOutTime,
    this.status,
    this.workingHours,
    this.remarks,
  });

  factory AttendanceLog.fromJson(Map<String, dynamic> json) {
    return AttendanceLog(
      id: json['id'] as String,
      employeeId: json['employee_id'] as String,
      date: DateTime.parse(json['attendance_date'] as String),
      checkInTime: json['check_in_time'] == null ? null : DateTime.parse(json['check_in_time'] as String),
      checkOutTime: json['check_out_time'] == null ? null : DateTime.parse(json['check_out_time'] as String),
      status: json['status'] as String?,
      workingHours: (json['working_hours'] as num?)?.toDouble(),
      remarks: json['remarks'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'attendance_date': date.toIso8601String().split('T')[0], // Only Date part usually
      'check_in_time': checkInTime?.toIso8601String(),
      'check_out_time': checkOutTime?.toIso8601String(),
      'status': status,
      'working_hours': workingHours,
      'remarks': remarks,
    };
  }
}
