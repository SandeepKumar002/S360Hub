class Address {
  final String id;
  final String? orgId;
  final String? ownerTable;
  final String? ownerId;
  final String? addressType;
  final String? line1;
  final String? line2;
  final String? city;
  final String? district;
  final String? state;
  final String? country;
  final String? pincode;
  final bool isDefault;
  final DateTime? createdAt;
  final Map<String, dynamic> metadata;

  Address({
    required this.id,
    this.orgId,
    this.ownerTable,
    this.ownerId,
    this.addressType,
    this.line1,
    this.line2,
    this.city,
    this.district,
    this.state,
    this.country,
    this.pincode,
    this.isDefault = false,
    this.createdAt,
    this.metadata = const {},
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      ownerTable: json['owner_table'] as String?,
      ownerId: json['owner_id'] as String?,
      addressType: json['address_type'] as String?,
      line1: json['line1'] as String?,
      line2: json['line2'] as String?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      pincode: json['pincode'] as String?,
      isDefault: json['is_default'] as bool? ?? false,
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'org_id': orgId,
      'owner_table': ownerTable,
      'owner_id': ownerId,
      'address_type': addressType,
      'line1': line1,
      'line2': line2,
      'city': city,
      'district': district,
      'state': state,
      'country': country,
      'pincode': pincode,
      'is_default': isDefault,
      'metadata': metadata,
    };
  }
}
