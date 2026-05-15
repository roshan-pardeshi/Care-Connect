import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/medicine_provider.dart';
import '../providers/health_provider.dart';
import '../providers/location_provider.dart';
import 'medicine_reminder_screen.dart';
import 'health_entry_screen.dart';
import 'emergency_button_screen.dart';

class ParentDashboard extends StatefulWidget {
  const ParentDashboard({super.key});

  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.user!.uid;
    Provider.of<MedicineProvider>(context, listen: false).loadMedicines(userId);
    Provider.of<HealthProvider>(context, listen: false).loadHealthRecords(userId);
    Provider.of<LocationProvider>(context, listen: false).startLocationTracking(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parent Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Provider.of<AuthProvider>(context, listen: false).signOut(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildDashboardCard(
                    'Medicine Reminders',
                    Icons.medication,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MedicineReminderScreen()),
                    ),
                  ),
                  _buildDashboardCard(
                    'Health Entry',
                    Icons.health_and_safety,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const HealthEntryScreen()),
                    ),
                  ),
                  _buildDashboardCard(
                    'Emergency',
                    Icons.warning,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EmergencyButtonScreen()),
                    ),
                  ),
                  _buildDashboardCard(
                    'Call Child',
                    Icons.call,
                    () => _callChild(),
                  ),
                  _buildDashboardCard(
                    'Voice Assistant',
                    Icons.mic,
                    () => _activateVoiceAssistant(),
                  ),
                  _buildDashboardCard(
                    'Daily Schedule',
                    Icons.schedule,
                    () => _showSchedule(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Emergency button at bottom
            SizedBox(
              width: double.infinity,
              height: 80,
              child: ElevatedButton(
                onPressed: () => _emergencyPressed(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'EMERGENCY',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.blue),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  void _callChild() {
    // Implement call to child
  }

  void _activateVoiceAssistant() {
    // Implement voice assistant
  }

  void _showSchedule() {
    // Show daily schedule
  }

  void _emergencyPressed() {
    // Trigger emergency
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EmergencyButtonScreen()),
    );
  }
}