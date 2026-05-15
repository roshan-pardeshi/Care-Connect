import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/medicine_provider.dart';
import '../providers/health_provider.dart';
import '../providers/location_provider.dart';
import 'medicine_management_screen.dart';
import 'health_reports_screen.dart';
import 'location_tracking_screen.dart';

class ChildDashboard extends StatefulWidget {
  const ChildDashboard({super.key});

  @override
  State<ChildDashboard> createState() => _ChildDashboardState();
}

class _ChildDashboardState extends State<ChildDashboard> {
  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.userModel?.parentId != null) {
      Provider.of<MedicineProvider>(context, listen: false).loadMedicines(authProvider.userModel!.parentId!);
      Provider.of<HealthProvider>(context, listen: false).loadHealthRecords(authProvider.userModel!.parentId!);
      Provider.of<LocationProvider>(context, listen: false).startLocationTracking(authProvider.userModel!.parentId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Child Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Provider.of<AuthProvider>(context, listen: false).signOut(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildDashboardCard(
              'Medicine Management',
              Icons.medication,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MedicineManagementScreen()),
              ),
            ),
            _buildDashboardCard(
              'Health Reports',
              Icons.health_and_safety,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HealthReportsScreen()),
              ),
            ),
            _buildDashboardCard(
              'Location Tracking',
              Icons.location_on,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LocationTrackingScreen()),
              ),
            ),
            _buildDashboardCard(
              'Emergency Alerts',
              Icons.warning,
              () => _showEmergencyAlerts(),
            ),
            _buildDashboardCard(
              'Video Call',
              Icons.video_call,
              () => _startVideoCall(),
            ),
            _buildDashboardCard(
              'Settings',
              Icons.settings,
              () => _showSettings(),
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

  void _showEmergencyAlerts() {
    // Show alerts history
  }

  void _startVideoCall() {
    // Implement video call
  }

  void _showSettings() {
    // Show settings
  }
}