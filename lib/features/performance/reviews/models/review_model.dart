class PerformanceReview {
  final String id;
  final String reviewCycleId; // Simplified
  final String employeeId;
  final String? reviewerId;
  final String? status; // 'draft', 'submitted', 'completed'
  final double? rating;
  final String? summary;

  PerformanceReview({
    required this.id,
    required this.reviewCycleId,
    required this.employeeId,
    this.reviewerId,
    this.status,
    this.rating,
    this.summary,
  });

  factory PerformanceReview.fromJson(Map<String, dynamic> json) {
    return PerformanceReview(
      id: json['id'] as String,
      reviewCycleId: json['cycle_id'] as String? ?? 'default', 
      employeeId: json['employee_id'] as String,
      reviewerId: json['reviewer_id'] as String?,
      status: json['status'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      summary: json['summary'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'reviewer_id': reviewerId,
      'status': status,
      'rating': rating,
      'summary': summary,
      // 'cycle_id' omitted for simplicity in basic CRUD
    };
  }
}
