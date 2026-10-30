class Contact {
  const Contact({this.id, required this.name, required this.phone});

  final int? id;
  final String name;
  final String phone;

  Map<String, Object?> toMap() => {
        if (id != null) 'id': id,
        'name': name,
        'phone': phone,
      };

  factory Contact.fromMap(Map<String, Object?> map) => Contact(
        id: map['id'] as int,
        name: map['name'] as String,
        phone: map['phone'] as String,
      );
}
