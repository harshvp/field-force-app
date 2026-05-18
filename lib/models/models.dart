// models
class User {
  final String id;
  final String name;
  final String role; // 'Admin', 'Manager', or 'Agent'

  User({required this.id, required this.name, required this.role});
}

class Task {
  final String id;
  final String title;
  final String description;
  final String assigneeId;
  String status;

  Task({required this.id, required this.title, required this.description, required this.assigneeId,
    this.status = 'Pending',
  });
}

class ActivityLog {
  final String title;
  final String originalNotes;
  final String aiSummary;
  final bool isWarning;

  ActivityLog({required this.title, required this.originalNotes, required this.aiSummary, required this.isWarning});
}