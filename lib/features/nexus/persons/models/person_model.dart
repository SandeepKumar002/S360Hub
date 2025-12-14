class Person {
  final String id;
  final String? orgId;
  final String firstName;
  final String lastName;
  final String? displayName;
  final String? email;
  final String? phone;
  final String? otpMethod; // 'mobile_only', 'email_only', 'email_and_mobile'
  final bool isOrgAdmin;
  final bool isDeleted;
  final DateTime? createdAt;
  final Map<String, dynamic> metadata;

  Person({
    required this.id,
    this.orgId,
    required this.firstName,
    required this.lastName,
    this.displayName,
    this.email,
    this.phone,
    this.otpMethod,
    this.isOrgAdmin = false,
    this.isDeleted = false,
    this.createdAt,
    this.metadata = const {},
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      displayName: json['display_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      otpMethod: json['otp_method'] as String?,
      isOrgAdmin: json['is_org_admin'] as bool? ?? false,
      isDeleted: json['is_deleted'] as bool? ?? false,
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'org_id': orgId,
      'first_name': firstName,
      'last_name': lastName,
      'display_name': displayName,
      'email': email,
      'phone': phone,
      'otp_method': otpMethod,
      'is_org_admin': isOrgAdmin,
      'is_deleted': isDeleted,
      'metadata': metadata,
    };
  }
}
