import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/health_model.dart';

class HealthProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<HealthRecord> _records = [];
  bool _isLoading = false;

  List<HealthRecord> get records => _records;
  bool get isLoading => _isLoading;

  Future<void> loadHealthRecords(String userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('health_records')
          .where('userId', isEqualTo: userId)
          .orderBy('date', descending: true)
          .get();
      _records = snapshot.docs
          .map((doc) => HealthRecord.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('Error loading health records: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addHealthRecord(HealthRecord record) async {
    try {
      await _firestore.collection('health_records').add(record.toMap());
      _records.insert(0, record);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}