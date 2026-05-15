import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/medicine_provider.dart';
import '../models/medicine_model.dart';

class MedicineManagementScreen extends StatefulWidget {
  const MedicineManagementScreen({super.key});

  @override
  State<MedicineManagementScreen> createState() => _MedicineManagementScreenState();
}

class _MedicineManagementScreenState extends State<MedicineManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _dosage = '';
  List<String> _times = [];

  @override
  Widget build(BuildContext context) {
    final medicineProvider = Provider.of<MedicineProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Medicine Management')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _showAddMedicineDialog,
              child: const Text('Add Medicine'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: medicineProvider.medicines.length,
              itemBuilder: (context, index) {
                final medicine = medicineProvider.medicines[index];
                return ListTile(
                  title: Text(medicine.name),
                  subtitle: Text('${medicine.dosage} - ${medicine.times.join(', ')}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => medicineProvider.deleteMedicine(medicine.id),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddMedicineDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Medicine'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Medicine Name'),
                validator: (value) => value!.isEmpty ? 'Enter name' : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Dosage'),
                validator: (value) => value!.isEmpty ? 'Enter dosage' : null,
                onSaved: (value) => _dosage = value!,
              ),
              // For simplicity, add one time
              TextFormField(
                decoration: const InputDecoration(labelText: 'Time (HH:MM)'),
                validator: (value) => value!.isEmpty ? 'Enter time' : null,
                onSaved: (value) => _times = [value!],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: _addMedicine,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _addMedicine() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final medicineProvider = Provider.of<MedicineProvider>(context, listen: false);
    final authProvider = Provider.of(context, listen: false);
    final parentId = authProvider.userModel?.parentId ?? '';

    final medicine = Medicine(
      id: '', // Will be set by Firestore
      name: _name,
      dosage: _dosage,
      times: _times,
      userId: parentId,
    );

    medicineProvider.addMedicine(medicine);
    Navigator.pop(context);
  }
}