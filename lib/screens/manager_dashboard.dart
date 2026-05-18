import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/activity_card.dart';
import '../main.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../providers/auth_provider.dart';
import 'create_task_screen.dart';


// Main UI for Manager

class ManagerDashboard extends StatelessWidget {
  const ManagerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<AuthProvider>().currentUser;
    // Watch the logs from the AppProvider
    final logs = context.watch<AppProvider>().allLogs;

    return Scaffold(
      appBar: AppBar(
        title: Text('Manager Dashboard - ${currentUser!.name}'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<AuthProvider>().logout(),
          )
        ],
      ),
      body: logs.isEmpty
          ? const Center(child: Text('No activity logs yet. Agents need to complete visits!'))
          : ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: logs.length,
        // We reverse the index so the newest logs appear at the top
        itemBuilder: (context, index) {
          final reversedIndex = logs.length - 1 - index;
          final log = logs[reversedIndex];

          return ActivityCard(log: log);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Open the new validated form screen!
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateTaskScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Create Task'),
      ),
    );
  }
}