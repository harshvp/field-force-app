import 'package:flutter/material.dart';
import '../models/models.dart';

class ActivityCard extends StatelessWidget {
  final ActivityLog log;

  const ActivityCard({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: log.isWarning ? Colors.red.shade50 : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  log.isWarning ? Icons.warning_amber_rounded : Icons.check_circle_outline,
                  color: log.isWarning ? Colors.red : Colors.green,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                      log.title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                  ),
                ),
              ],
            ),
            const Divider(),
            const Text('Original Agent Notes:', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.grey)),
            Text(log.originalNotes, style: const TextStyle(fontStyle: FontStyle.italic)),
            const SizedBox(height: 10),
            const Text('Mock AI Analysis:', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.grey)),
            Text(
                log.aiSummary,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: log.isWarning ? Colors.red.shade800 : Colors.green.shade800
                )
            ),
          ],
        ),
      ),
    );
  }
}