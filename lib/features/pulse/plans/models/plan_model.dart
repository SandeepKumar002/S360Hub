class SubscriptionPlan {
  final String id;
  final String planCode;
  final String displayName;
  final String? description;
  final double price;
  final String billingCycle;
  final int seatsLimit;
  final int storageLimitGb;
  final Map<String, dynamic> features;
  final Map<String, dynamic> metadata;
  final bool isDeleted;

  SubscriptionPlan({
    required this.id,
    required this.planCode,
    required this.displayName,
    this.description,
    this.price = 0.0,
    this.billingCycle = 'monthly',
    this.seatsLimit = 0,
    this.storageLimitGb = 0,
    this.features = const {},
    this.metadata = const {},
    this.isDeleted = false,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['id'] as String,
      planCode: json['plan_code'] as String? ?? '',
      displayName: json['display_name'] as String? ?? '',
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      billingCycle: json['billing_cycle'] as String? ?? 'monthly',
      seatsLimit: json['seats_limit'] as int? ?? 0,
      storageLimitGb: json['storage_limit_gb'] as int? ?? 0,
      features: json['features'] as Map<String, dynamic>? ?? {},
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      isDeleted: json['is_deleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plan_code': planCode,
      'display_name': displayName,
      'description': description,
      'price': price,
      'billing_cycle': billingCycle,
      'seats_limit': seatsLimit,
      'storage_limit_gb': storageLimitGb,
      'features': features,
      'metadata': metadata,
      'is_deleted': isDeleted,
    };
  }
}
