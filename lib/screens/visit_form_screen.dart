import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../providers/auth_provider.dart';
import 'create_task_screen.dart';

// UI and logic for visit forms screen
class VisitFormScreen extends StatefulWidget {
  final Task task;
  const VisitFormScreen({super.key, required this.task});

  @override
  State<VisitFormScreen> createState() => _VisitFormScreenState();
}

class _VisitFormScreenState extends State<VisitFormScreen> {
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<AuthProvider>().currentUser;

    return Scaffold(
      appBar: AppBar(title: Text('Complete: ${widget.task.title}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Enter Visit Notes:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: _notesController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'E.g., Finished restocking. The client was happy.',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
              onPressed: () {
                if (_notesController.text.isEmpty) return;

                // Trigger the Mock AI and save data
                context.read<AppProvider>().submitVisit(widget.task, _notesController.text, currentUser!.name);

                // Go back to the dashboard
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Visit logged and processed by AI!')),
                );
              },
              child: const Text('Submit Visit & Run AI'),
            )
          ],
        ),
      ),
    );
  }
}