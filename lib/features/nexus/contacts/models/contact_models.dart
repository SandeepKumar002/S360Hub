class Contact {
  final String id;
  final String? orgId;
  final String? personId;
  final String? contactType;
  final String? name;
  final String? designation;
  final String? phone;
  final String? email;
  final Map<String, dynamic> metadata;
  final DateTime? createdAt;
  final String? locationGps;

  Contact({
    required this.id,
    this.orgId,
    this.personId,
    this.contactType,
    this.name,
    this.designation,
    this.phone,
    this.email,
    this.metadata = const {},
    this.createdAt,
    this.locationGps,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      personId: json['person_id'] as String?,
      contactType: json['contact_type']?.toString(), // enum or text
      name: json['name'] as String?,
      designation: json['designation'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      locationGps: json['location_gps'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'org_id': orgId,
      'person_id': personId,
      'contact_type': contactType,
      'name': name,
      'designation': designation,
      'phone': phone,
      'email': email,
      'metadata': metadata,
      'location_gps': locationGps,
    };
  }
}
