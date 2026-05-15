import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/medicine_provider.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MedicineReminderScreen extends StatefulWidget {
  const MedicineReminderScreen({super.key});

  @override
  State<MedicineReminderScreen> createState() => _MedicineReminderScreenState();
}

class _MedicineReminderScreenState extends State<MedicineReminderScreen> {
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _speakReminders();
  }

  Future<void> _speakReminders() async {
    final medicineProvider = Provider.of<MedicineProvider>(context, listen: false);
    for (var medicine in medicineProvider.medicines) {
      await _flutterTts.speak('It\'s time to take your medicine: ${medicine.name}, dosage: ${medicine.dosage}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final medicineProvider = Provider.of<MedicineProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Medicine Reminders')),
      body: ListView.builder(
        itemCount: medicineProvider.medicines.length,
        itemBuilder: (context, index) {
          final medicine = medicineProvider.medicines[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(medicine.name, style: const TextStyle(fontSize: 24)),
              subtitle: Text('${medicine.dosage}\nTimes: ${medicine.times.join(', ')}', style: const TextStyle(fontSize: 18)),
              trailing: ElevatedButton(
                onPressed: () => _markAsTaken(medicine),
                child: const Text('Taken'),
              ),
            ),
          );
        },
      ),
    );
  }

  void _markAsTaken(Medicine medicine) {
    // Mark as taken, perhaps update Firestore
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${medicine.name} marked as taken')),
    );
  }
}