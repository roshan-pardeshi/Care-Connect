import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';
import 'notification_service.dart';

class FallDetectionService {
  final NotificationService _notificationService = NotificationService();
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  bool _isMonitoring = false;

  void startMonitoring() {
    if (_isMonitoring) return;

    _isMonitoring = true;
    _accelerometerSubscription = accelerometerEvents.listen(_onAccelerometerEvent);
  }

  void stopMonitoring() {
    _isMonitoring = false;
    _accelerometerSubscription?.cancel();
  }

  void _onAccelerometerEvent(AccelerometerEvent event) {
    double acceleration = event.x * event.x + event.y * event.y + event.z * event.z;
    double accelerationSqrt = sqrt(acceleration);

    // Threshold for fall detection (adjust based on testing)
  //   if (accelerationSqrt > 25.0) { // Example threshold
  //     _detectedFall();
  //   }
  // }

  void _detectedFall() {
    // Trigger emergency alert
    _notificationService.initialize().then((_) {
      // Send alert to child
      print('Fall detected! Sending emergency alert.');
    });
  }
}
