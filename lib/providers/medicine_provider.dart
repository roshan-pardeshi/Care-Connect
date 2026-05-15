import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/medicine_model.dart';

class MedicineProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Medicine> _medicines = [];
  bool _isLoading = false;

  List<Medicine> get medicines => _medicines;
  bool get isLoading => _isLoading;

  Future<void> loadMedicines(String userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('medicines')
          .where('userId', isEqualTo: userId)
          .get();
      _medicines = snapshot.docs
          .map((doc) => Medicine.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('Error loading medicines: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addMedicine(Medicine medicine) async {
    try {
      DocumentReference doc = await _firestore.collection('medicines').add(medicine.toMap());
      medicine = Medicine(
        id: doc.id,
        name: medicine.name,
        dosage: medicine.dosage,
        times: medicine.times,
        userId: medicine.userId,
        isActive: medicine.isActive,
      );
      _medicines.add(medicine);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateMedicine(Medicine medicine) async {
    try {
      await _firestore.collection('medicines').doc(medicine.id).update(medicine.toMap());
      int index = _medicines.indexWhere((m) => m.id == medicine.id);
      if (index != -1) {
        _medicines[index] = medicine;
        notifyListeners();
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteMedicine(String id) async {
    try {
      await _firestore.collection('medicines').doc(id).delete();
      _medicines.removeWhere((m) => m.id == id);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}