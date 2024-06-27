
class ContactModel {
  final int? id;
  final String name;
  final String number;

  ContactModel({this.id, required this.name, required this.number});

  factory ContactModel.fromJson(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'],
      name: map['name'],
      number: map['number'],
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number': number,
    };
  }
}