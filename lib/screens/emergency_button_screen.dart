import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class EmergencyButtonScreen extends StatefulWidget {
  const EmergencyButtonScreen({super.key});

  @override
  State<EmergencyButtonScreen> createState() => _EmergencyButtonScreenState();
}

class _EmergencyButtonScreenState extends State<EmergencyButtonScreen> {
  bool _isEmergencyActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Press the button below in case of emergency',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 200,
              height: 200,
              child: ElevatedButton(
                onPressed: _triggerEmergency,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isEmergencyActive ? Colors.red : Colors.redAccent,
                  shape: const CircleBorder(),
                  elevation: 10,
                ),
                child: const Icon(
                  Icons.warning,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_isEmergencyActive)
              const Text(
                'EMERGENCY ALERT SENT!',
                style: TextStyle(fontSize: 24, color: Colors.red, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }

  void _triggerEmergency() async {
    setState(() => _isEmergencyActive = true);

    // Send push notification
    // For demo, we'll simulate

    // Call emergency number
    final Uri phoneUri = Uri(scheme: 'tel', path: '911'); // Or child's number
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }

    // Send SMS
    final Uri smsUri = Uri(scheme: 'sms', path: '1234567890', queryParameters: {'body': 'EMERGENCY: Parent needs help!'});
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    }

    // In real app, integrate with Firebase Cloud Messaging to notify child

    Future.delayed(const Duration(seconds: 5), () {
      setState(() => _isEmergencyActive = false);
    });
  }
}