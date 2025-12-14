class JobApplication {
  final String id;
  final String jobId;
  final String? candidatePersonId;
  final String? status; // 'applied', 'interview', 'offer', 'hired'
  final DateTime? appliedAt;
  final Map<String, dynamic> metadata;

  JobApplication({
    required this.id,
    required this.jobId,
    this.candidatePersonId,
    this.status,
    this.appliedAt,
    this.metadata = const {},
  });

  factory JobApplication.fromJson(Map<String, dynamic> json) {
    return JobApplication(
      id: json['id'] as String,
      jobId: json['job_id'] as String,
      candidatePersonId: json['candidate_person_id'] as String?,
      status: json['status'] as String?,
      appliedAt: json['applied_at'] == null ? null : DateTime.parse(json['applied_at'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'job_id': jobId,
      'candidate_person_id': candidatePersonId,
      'status': status,
      'applied_at': appliedAt?.toIso8601String(),
      'metadata': metadata,
    };
  }
}
