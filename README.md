Field Force Management System (Option 1)

Overview
A minimal, permission-aware Flutter application designed for a Field Force team. It features role-based access control, task assignment, visit tracking, and a mocked AI integration that automatically analyzes field agent visit notes to generate actionable summaries and warning flags.

Tech Stack
Framework: Flutter (Dart)
State Management: Provider
Data Layer: Local Seeded In-Memory Data

Core Features Implemented
Role-Based Access: UI dynamically routes and restricts actions based on the logged-in user (Manager vs. Agent).
Task Management: Managers can create and assign tasks. Forms include strong validation and simulated async loading states. Agents can view their specifically assigned tasks.
Visit Tracking: Agents can complete tasks and submit visit notes.
Mock AI Engine: A deterministic local function parses visit notes for keywords (e.g., "broken", "issue", "upset") to flag high-priority escalations and generate synthetic summaries.
Activity Timeline:A real-time, global history view of task creation and AI-analyzed visit logs, visually distinguishing success states from warning states.

Demo Credentials & Seeded Data
The application boots with an authentication screen featuring strict form validation. Please use the following demo credentials to test the role-based routing:

Manager Access (Assign tasks, view timeline):
* Username: `manager`
* Password: `demo123`

Field Agent Access (Complete visits, trigger AI):
* Username: `agent`
* Password: `demo123`

## How to Run Locally
1. Clone this repository.
2. Ensure you have the Flutter SDK installed.
3. Ensure you either have Android Studio or VS code installed
4. Run `flutter pub get` to install the Provider dependency.
5. Run `flutter run` on an Android Emulator or Chrome instance.

