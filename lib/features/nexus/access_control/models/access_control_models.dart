class ModuleUser {
  final String id;
  final String? personId;
  final String? username;
  final String? displayName;
  final List<String> roles;
  final bool isDeleted;
  final DateTime? createdAt;
  final Map<String, dynamic> metadata;

  ModuleUser({
    required this.id,
    this.personId,
    this.username,
    this.displayName,
    this.roles = const [],
    this.isDeleted = false,
    this.createdAt,
    this.metadata = const {},
  });

  factory ModuleUser.fromJson(Map<String, dynamic> json) {
    return ModuleUser(
      id: json['id'] as String,
      personId: json['person_id'] as String?,
      username: json['username'] as String?,
      displayName: json['display_name'] as String?,
      roles: (json['roles'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      isDeleted: json['is_deleted'] as bool? ?? false,
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'person_id': personId,
      'username': username,
      'display_name': displayName,
      'roles': roles,
      'is_deleted': isDeleted,
      'metadata': metadata,
    };
  }
}

class ModuleRole {
  final String id;
  final String roleCode;
  final String displayName;
  final String? description;
  final Map<String, dynamic> permissions;
  final DateTime? createdAt;

  ModuleRole({
    required this.id,
    required this.roleCode,
    required this.displayName,
    this.description,
    this.permissions = const {},
    this.createdAt,
  });

  factory ModuleRole.fromJson(Map<String, dynamic> json) {
    return ModuleRole(
      id: json['id'] as String,
      roleCode: json['role_code'] as String? ?? '',
      displayName: json['display_name'] as String? ?? '',
      description: json['description'] as String?,
      permissions: json['permissions'] as Map<String, dynamic>? ?? {},
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role_code': roleCode,
      'display_name': displayName,
      'description': description,
      'permissions': permissions,
    };
  }
}

class ModuleTeam {
  final String id;
  final String teamName;
  final String? description;
  final String? leaderId;
  final bool isActive;
  final DateTime? createdAt;

  ModuleTeam({
    required this.id,
    required this.teamName,
    this.description,
    this.leaderId,
    this.isActive = true,
    this.createdAt,
  });

  factory ModuleTeam.fromJson(Map<String, dynamic> json) {
    return ModuleTeam(
      id: json['id'] as String,
      teamName: json['team_name'] as String? ?? '',
      description: json['description'] as String?,
      leaderId: json['leader_id'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'team_name': teamName,
      'description': description,
      'leader_id': leaderId,
      'is_active': isActive,
    };
  }
}
