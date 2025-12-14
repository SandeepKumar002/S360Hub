class JobPosting {
  final String id;
  final String orgId;
  final String jobCode;
  final String title;
  final String? dept;
  final String? hiringManagerId;
  final String? location;
  final String? status; // 'draft', 'published', 'closed'
  final String? description;
  final DateTime? createdAt;
  
  JobPosting({
    required this.id,
    required this.orgId,
    required this.jobCode,
    required this.title,
    this.dept,
    this.hiringManagerId,
    this.location,
    this.status,
    this.description,
    this.createdAt,
  });

  factory JobPosting.fromJson(Map<String, dynamic> json) {
    return JobPosting(
      id: json['id'] as String,
      orgId: json['org_id'] as String? ?? '', // Handle null locally if needed
      jobCode: json['job_code'] as String? ?? '',
      title: json['title'] as String? ?? '',
      dept: json['dept'] as String?,
      hiringManagerId: json['hiring_manager_id'] as String?,
      location: json['location'] as String?,
      status: json['status'] as String?,
      description: json['description'] as String?,
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'org_id': orgId,
      'job_code': jobCode,
      'title': title,
      'dept': dept,
      'hiring_manager_id': hiringManagerId,
      'location': location,
      'status': status,
      'description': description,
    };
  }
}
