import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/health_provider.dart';
import '../models/health_model.dart';

class HealthEntryScreen extends StatefulWidget {
  const HealthEntryScreen({super.key});

  @override
  State<HealthEntryScreen> createState() => _HealthEntryScreenState();
}

class _HealthEntryScreenState extends State<HealthEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  String _type = 'blood_pressure';
  double _value = 0.0;
  String _unit = 'mmHg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health Entry')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _type,
                items: const [
                  DropdownMenuItem(value: 'blood_pressure', child: Text('Blood Pressure')),
                  DropdownMenuItem(value: 'sugar', child: Text('Sugar Level')),
                ],
                onChanged: (value) => setState(() => _type = value!),
                decoration: const InputDecoration(labelText: 'Type'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Value'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter value' : null,
                onSaved: (value) => _value = double.parse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Unit'),
                initialValue: _unit,
                onSaved: (value) => _unit = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveEntry,
                child: const Text('Save Entry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveEntry() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final healthProvider = Provider.of<HealthProvider>(context, listen: false);
    final authProvider = Provider.of(context, listen: false);
    final userId = authProvider.user!.uid;

    final record = HealthRecord(
      id: '',
      userId: userId,
      type: _type,
      value: _value,
      unit: _unit,
      date: DateTime.now(),
    );

    healthProvider.addHealthRecord(record);
    Navigator.pop(context);
  }
}