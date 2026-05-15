class Medicine {
  final String id;
  final String name;
  final String dosage;
  final List<String> times; // list of times in HH:MM format
  final String userId; // parent id
  final bool isActive;

  Medicine({
    required this.id,
    required this.name,
    required this.dosage,
    required this.times,
    required this.userId,
    this.isActive = true,
  });

  factory Medicine.fromMap(Map<String, dynamic> data, String id) {
    return Medicine(
      id: id,
      name: data['name'] ?? '',
      dosage: data['dosage'] ?? '',
      times: List<String>.from(data['times'] ?? []),
      userId: data['userId'] ?? '',
      isActive: data['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dosage': dosage,
      'times': times,
      'userId': userId,
      'isActive': isActive,
    };
  }
}