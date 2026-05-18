import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../providers/auth_provider.dart';

// UI and logic for create tasks screen
class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  // Global key to identify the form and run validation
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  // this is getting assigned to u2 by default
  String _selectedAssignee = 'u2';

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final managerName = context.read<AuthProvider>().currentUser!.name;

      try {
        // Waits for the simulated network request to finish
        await context.read<AppProvider>().addTask(
            _titleController.text,
            _descController.text,
            _selectedAssignee,
            managerName
        );

        // If successful, show success and pop screen
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Task successfully created!'), backgroundColor: Colors.green),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        // HANDLE THE ERROR STATE CLEANLY
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to assign task. Please try again.'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Task Title',
                  border: OutlineInputBorder(),
                ),
                // VALIDATION: Cannot be empty, must be > 3 chars
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a task title';
                  }
                  if (value.trim().length < 3) {
                    return 'Title must be at least 3 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Task Description',
                  border: OutlineInputBorder(),
                ),
                //  VALIDATION: Cannot be empty
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please provide a task description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedAssignee,
                decoration: const InputDecoration(
                  labelText: 'Assign To',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'u2', child: Text('Charlie Agent (Field Agent)')),
                  DropdownMenuItem(value: 'u1', child: Text('Bob Manager (Manager)')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedAssignee = value!;
                  });
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16)
                ),
                // Disable the button while loading so they can't double-click
                onPressed: context.watch<AppProvider>().isLoading ? null : _submitForm,
                child: context.watch<AppProvider>().isLoading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Assign Task', style: TextStyle(fontSize: 16)),
              )
            ],
          ),
        ),
      ),
    );
  }
}