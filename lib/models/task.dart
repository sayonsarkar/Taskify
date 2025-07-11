class Task {
  int? id;
  String title;
  String description;
  DateTime createdAt;
  bool isCompleted;

  Task({
    this.id,
    required this.title,
    this.description = '',
    DateTime? createdAt,
    this.isCompleted = false,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'is_completed': isCompleted ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      createdAt: DateTime.parse(map['created_at']),
      isCompleted: map['is_completed'] == 1,
    );
  }
}
