# CareConnect – Smart Elderly Care System

A comprehensive mobile application built with Flutter to help elderly parents stay safe, healthy, and connected with their children.

## Features

### For Children (Admin)
- Register/Login with email and password
- Add and manage parent profiles
- Set medicine schedules with reminders
- View real-time parent location on map
- Receive emergency alerts and notifications
- View health reports (Blood Pressure, Sugar levels)
- Video call functionality
- Manage app settings

### For Parents (Elderly Users)
- Simple OTP-based login
- Large, accessible UI with voice feedback
- Voice-enabled interactions (Marathi/Hindi/English)
- Medicine reminders with voice alerts
- One-tap emergency panic button
- View daily schedules
- Manual health data entry

### Core Features
- **Medicine Reminder System**: Time-based alerts, voice reminders, missed medicine notifications
- **Emergency System**: Panic button with push notifications, SMS alerts, and auto-calls
- **Live Location Tracking**: Real-time GPS tracking with map visualization
- **Health Tracking**: Manual entry for BP and sugar levels with weekly reports
- **AI Voice Assistant**: Voice commands for medicine reminders, calls, etc.
- **Fall Detection**: Sensor-based fall detection with automatic alerts
- **Smart Alerts**: Geofencing for safe zones
- **Communication**: One-tap calls, video calls, chat messaging

## Tech Stack

- **Frontend**: Flutter (Cross-platform mobile app)
- **Backend**: Firebase (Authentication, Firestore, Realtime Database)
- **APIs**:
  - Google Maps API (Location services)
  - Firebase Cloud Messaging (Push notifications)
  - Twilio (SMS/Call alerts)
  - Speech-to-Text & Text-to-Speech APIs
- **Additional Libraries**:
  - Provider (State management)
  - Geolocator (GPS tracking)
  - Google Maps Flutter (Map integration)
  - Agora RTC (Video calls)
  - Sensors Plus (Fall detection)
  - Flutter TTS (Text-to-speech)

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── firebase_options.dart     # Firebase configuration
├── models/                   # Data models
│   ├── user_model.dart
│   ├── medicine_model.dart
│   └── health_model.dart
├── providers/                # State management
│   ├── auth_provider.dart
│   ├── medicine_provider.dart
│   ├── health_provider.dart
│   └── location_provider.dart
├── screens/                  # UI screens
│   ├── login_screen.dart
│   ├── child_dashboard.dart
│   ├── parent_dashboard.dart
│   ├── medicine_management_screen.dart
│   ├── medicine_reminder_screen.dart
│   ├── emergency_button_screen.dart
│   ├── health_entry_screen.dart
│   ├── health_reports_screen.dart
│   └── location_tracking_screen.dart
├── services/                 # Business logic services
├── utils/                    # Utility functions
└── widgets/                  # Reusable UI components
```

## Setup Instructions

### Prerequisites
1. Install Flutter SDK: https://flutter.dev/docs/get-started/install/windows
   - Download the SDK
   - Extract to a folder (e.g., C:\flutter)
   - Add C:\flutter\bin to your PATH
   - Run `flutter doctor` to verify installation

2. Install Android Studio: https://developer.android.com/studio
   - For Android development
   - Or Xcode for iOS (on macOS)

3. Set up Firebase project: https://console.firebase.google.com/
   - Create a new project
   - Enable Authentication (Email/Password and Phone)
   - Enable Firestore Database
   - Enable Cloud Messaging
   - Add Android/iOS apps and download config files

### Installation
1. Clone or download the project:
   ```bash
   cd "c:\Users\Admin\OneDrive\Desktop\Care Connect"
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Configure Firebase:
   - Place `google-services.json` in `android/app/`
   - Place `GoogleService-Info.plist` in `ios/Runner/`
   - Update `lib/firebase_options.dart` with your Firebase config values

4. Configure API keys:
   - Get Google Maps API key and add to:
     - `android/app/src/main/AndroidManifest.xml`
     - `ios/Runner/Info.plist`
   - For Twilio, add credentials to environment or secure storage

5. Run the app:
   ```bash
   flutter run
   ```

### Firebase Configuration
Update `lib/firebase_options.dart` with your actual Firebase project details:

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'your-actual-api-key',
  appId: 'your-actual-app-id',
  messagingSenderId: 'your-sender-id',
  projectId: 'your-project-id',
  storageBucket: 'your-project-id.appspot.com',
);
```

## Firebase Setup

### Firestore Collections
- `users`: User profiles (children and parents)
- `medicines`: Medicine schedules
- `health_records`: Health data entries
- `locations`: Real-time location data
- `alerts`: Emergency and system alerts

### Authentication
- Email/Password for children
- Phone OTP for parents

### Cloud Messaging
- Push notifications for medicine reminders
- Emergency alerts
- Location updates

## Security Features

- Secure authentication with JWT tokens
- Data encryption for sensitive health information
- Role-based access control
- Secure API communications

## Testing

### Unit Testing
```bash
flutter test
```

### Integration Testing
```bash
flutter drive --target=test_driver/app.dart
```

### Real Device Testing
- Test GPS functionality
- Test sensor-based fall detection
- Test push notifications
- Test emergency calling

## Deployment

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## API Documentation

### Authentication Endpoints
- `POST /auth/login` - User login
- `POST /auth/signup` - User registration
- `POST /auth/otp` - Send OTP for parent login

### Medicine Management
- `GET /medicines` - Get medicine list
- `POST /medicines` - Add new medicine
- `PUT /medicines/{id}` - Update medicine
- `DELETE /medicines/{id}` - Delete medicine

### Health Tracking
- `GET /health` - Get health records
- `POST /health` - Add health entry

### Location Services
- `GET /location` - Get current location
- `POST /location/track` - Start location tracking

### Emergency System
- `POST /emergency` - Trigger emergency alert

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support, email support@careconnect.com or join our Slack channel.

## Future Enhancements

- Smartwatch integration
- Offline mode with SMS fallbacks
- Multi-language support
- Doctor appointment booking
- Video consultation with healthcare providers
- Advanced AI chatbot for companionship
- Integration with smart home devices