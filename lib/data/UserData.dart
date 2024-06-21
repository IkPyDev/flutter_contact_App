class UserData {
  final String id;
  final String name;
  final String phone;

  UserData({required this.id, required this.name, required this.phone});

  factory UserData.fromJson(String id,Map<String, dynamic> json) {
    return UserData(
      id: id,
      name: json['name'] as String,
      phone: json['phone'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'phone': phone};
  }
}