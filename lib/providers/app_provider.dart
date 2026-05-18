import 'package:flutter/cupertino.dart';

import '../models/models.dart';

class AppProvider extends ChangeNotifier {


  // the hardcoded tasks
  final List<Task> _tasks = [
    Task(id: 't1', title: 'Restock Main Street Store', description: 'Check inventory and restock endcaps.', assigneeId: 'u2'),
    Task(id: 't2', title: 'Audit Downtown Clinic', description: 'Review safety protocols.', assigneeId: 'u2'),
    Task(id: 't3', title: 'Manager Review', description: 'Review quarterly goals.', assigneeId: 'u1'),  //there is no u1 as of now
  ];

  // Activity History Timeline
  final List<ActivityLog> _logs = [];

  List<Task> getTasksForUser(String userId) {
    return _tasks.where((task) => task.assigneeId == userId).toList();
  }

  List<ActivityLog> get allLogs => _logs;



  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // function is async
  Future<void> addTask(String title, String description, String assigneeId, String managerName) async {
    // 1. TRIGGER LOADING STATE
    _isLoading = true;
    notifyListeners();

    try {
      // 2. FAKE A NETWORK DELAY (1.5 seconds)
      await Future.delayed(const Duration(milliseconds: 1000));

      // error handling logic if needs to be shown
      //throw Exception("Mock Server Timeout");

      final newTask = Task(
          id: 't_${DateTime.now().millisecondsSinceEpoch}',
          title: title,
          description: description,
          assigneeId: assigneeId
      );
      _tasks.add(newTask);

      _logs.add(ActivityLog(
        title: 'Task Created: $title',
        originalNotes: 'Task formally assigned to Agent.',
        aiSummary: 'System note: Manual task dispatched by $managerName.',
        isWarning: false,
      ));
    } finally {
      // 3. TURN OFF LOADING STATE
      _isLoading = false;
      notifyListeners();
    }
  }

  //  Mock AI logic
  void submitVisit(Task task, String notes, String agentName) {
    // 1. Update task status
    task.status = 'Completed';

    // 2. Mock AI Logic: Scan for specific keywords
    final lowerNotes = notes.toLowerCase();
    final isWarning = lowerNotes.contains('issue') || lowerNotes.contains('broken') || lowerNotes.contains('upset') || lowerNotes.contains('angry') || lowerNotes.contains('wrong');

    // 3. Generate Mock AI Output
    final aiSummary = isWarning
        ? "🚨 AI WARNING: High priority issue detected. Manager follow-up recommended."
        : "✅ AI SUMMARY: Routine visit completed successfully. No anomalies detected.";

    // 4. Log the activity with both original notes and AI output
    _logs.add(ActivityLog(
      title: 'Visit Completed by $agentName for ${task.title}',
      originalNotes: notes,
      aiSummary: aiSummary,
      isWarning: isWarning,
    ));

    notifyListeners();
  }
}