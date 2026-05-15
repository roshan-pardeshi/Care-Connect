class UserModel {
  final String uid;
  final String email;
  final String role; // 'child' or 'parent'
  final String? phoneNumber;
  final String? name;
  final String? parentId; // for child role, link to parent
  final String? childId; // for parent role, link to child

  UserModel({
    required this.uid,
    required this.email,
    required this.role,
    this.phoneNumber,
    this.name,
    this.parentId,
    this.childId,
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      email: data['email'] ?? '',
      role: data['role'] ?? 'parent',
      phoneNumber: data['phoneNumber'],
      name: data['name'],
      parentId: data['parentId'],
      childId: data['childId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'role': role,
      'phoneNumber': phoneNumber,
      'name': name,
      'parentId': parentId,
      'childId': childId,
    };
  }
}