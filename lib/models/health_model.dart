class HealthRecord {
  final String id;
  final String userId;
  final String type; // 'blood_pressure' or 'sugar'
  final double value;
  final String unit;
  final DateTime date;

  HealthRecord({
    required this.id,
    required this.userId,
    required this.type,
    required this.value,
    required this.unit,
    required this.date,
  });

  factory HealthRecord.fromMap(Map<String, dynamic> data, String id) {
    return HealthRecord(
      id: id,
      userId: data['userId'] ?? '',
      type: data['type'] ?? '',
      value: (data['value'] ?? 0.0).toDouble(),
      unit: data['unit'] ?? '',
      date: DateTime.parse(data['date'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'type': type,
      'value': value,
      'unit': unit,
      'date': date.toIso8601String(),
    };
  }
}