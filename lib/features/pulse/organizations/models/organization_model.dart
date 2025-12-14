class Organization {
  final String id;
  final String name;
  final String code;
  final String? domain;
  final String? planId;
  final String? status; // 'active', 'trial', 'suspended' etc.
  final int userCapacity;
  final int activeUserCount;
  final String? billingContactId;
  final DateTime? subscriptionStartDate;
  final DateTime? subscriptionEndDate;
  final Map<String, dynamic> metadata;
  final DateTime? createdAt;

  Organization({
    required this.id,
    required this.name,
    required this.code,
    this.domain,
    this.planId,
    this.status,
    this.userCapacity = 0,
    this.activeUserCount = 0,
    this.billingContactId,
    this.subscriptionStartDate,
    this.subscriptionEndDate,
    this.metadata = const {},
    this.createdAt,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      code: json['code'] as String? ?? '',
      domain: json['domain'] as String?,
      planId: json['plan_id'] as String?,
      status: json['status'] as String?,
      userCapacity: json['user_capacity'] as int? ?? 0,
      activeUserCount: json['active_user_count'] as int? ?? 0,
      billingContactId: json['billing_contact_id'] as String?,
      subscriptionStartDate: json['subscription_start_date'] == null ? null : DateTime.parse(json['subscription_start_date'] as String),
      subscriptionEndDate: json['subscription_end_date'] == null ? null : DateTime.parse(json['subscription_end_date'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'domain': domain,
      'plan_id': planId,
      'status': status,
      'user_capacity': userCapacity,
      // 'active_user_count': activeUserCount, // Usually computed/read-only
      'billing_contact_id': billingContactId,
      'subscription_start_date': subscriptionStartDate?.toIso8601String(),
      'subscription_end_date': subscriptionEndDate?.toIso8601String(),
      'metadata': metadata,
    };
  }
}
