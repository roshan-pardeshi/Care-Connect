import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/health_provider.dart';

class HealthReportsScreen extends StatelessWidget {
  const HealthReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final healthProvider = Provider.of<HealthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Health Reports')),
      body: healthProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: healthProvider.records.length,
              itemBuilder: (context, index) {
                final record = healthProvider.records[index];
                return ListTile(
                  title: Text('${record.type} - ${record.value} ${record.unit}'),
                  subtitle: Text(record.date.toString()),
                );
              },
            ),
    );
  }
}