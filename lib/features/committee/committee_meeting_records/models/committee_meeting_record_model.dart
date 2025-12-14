class CommitteeCommitteeMeetingRecord {
  final String id;
  final String? meetingId;
  final String? agendaItem;
  final String? discussion;
  final String? decision;
  final Map<String, dynamic>? actionItems;
  final String? responsiblePersonId;
  final DateTime? dueDate;
  final String? status;
  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;

  CommitteeCommitteeMeetingRecord({
    required this.id,
    this.meetingId,
    this.agendaItem,
    this.discussion,
    this.decision,
    this.actionItems,
    this.responsiblePersonId,
    this.dueDate,
    this.status,
    this.metadata,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
  });

  factory CommitteeCommitteeMeetingRecord.fromJson(Map<String, dynamic> json) {
    return CommitteeCommitteeMeetingRecord(
      id: json['id'] as String,
      meetingId: json['meeting_id'] as String?,
      agendaItem: json['agenda_item'] as String?,
      discussion: json['discussion'] as String?,
      decision: json['decision'] as String?,
      actionItems: json['action_items'] as Map<String, dynamic>? ?? {},
      responsiblePersonId: json['responsible_person_id'] as String?,
      dueDate: json['due_date'] == null ? null : DateTime.parse(json['due_date'] as String),
      status: json['status'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String?,
      updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at'] as String),
      updatedBy: json['updated_by'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'meeting_id': meetingId,
      'agenda_item': agendaItem,
      'discussion': discussion,
      'decision': decision,
      'action_items': actionItems,
      'responsible_person_id': responsiblePersonId,
      'due_date': dueDate?.toIso8601String(),
      'status': status,
      'metadata': metadata,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
      'updated_at': updatedAt?.toIso8601String(),
      'updated_by': updatedBy,
    };
  }
}
