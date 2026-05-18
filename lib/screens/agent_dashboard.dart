import 'package:field_force/screens/visit_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../providers/auth_provider.dart';

// Main UI for agent screen
class AgentDashboard extends StatelessWidget {
  const AgentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Get the current user from AuthProvider
    final currentUser = context.read<AuthProvider>().currentUser;
    // 2. Get the tasks for this specific user from AppProvider
    final myTasks = context.watch<AppProvider>().getTasksForUser(currentUser!.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Agent Dashboard - ${currentUser.name}'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<AuthProvider>().logout(),
          )
        ],
      ),
      //  scrollable list of tasks
      body: myTasks.isEmpty
          ? const Center(child: Text('No tasks assigned!'))
          : ListView.builder(
        itemCount: myTasks.length,
        itemBuilder: (context, index) {
          final task = myTasks[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(task.description),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                if (task.status == 'Completed') {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task already completed!')));
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VisitFormScreen(task: task)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}