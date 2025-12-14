class Objective {
  final String id;
  final String title;
  final String? description;
  final String? ownerId;
  final DateTime? dueDate;
  final double progress; // 0.0 to 100.0
  final String? status; // 'on_track', 'at_risk', 'completed'

  Objective({
    required this.id,
    required this.title,
    this.description,
    this.ownerId,
    this.dueDate,
    this.progress = 0.0,
    this.status,
  });

  factory Objective.fromJson(Map<String, dynamic> json) {
    return Objective(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      ownerId: json['owner_id'] as String?,
      dueDate: json['due_date'] == null ? null : DateTime.parse(json['due_date'] as String),
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'owner_id': ownerId,
      'due_date': dueDate?.toIso8601String(),
      'progress': progress,
      'status': status,
    };
  }
}
