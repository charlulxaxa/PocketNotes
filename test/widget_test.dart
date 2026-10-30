import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_notes/data/contact.dart';

void main() {
  test('Contact converts to and from a map', () {
    const contact = Contact(id: 1, name: 'Ana', phone: '0917');
    final copy = Contact.fromMap(contact.toMap());

    expect(copy.id, 1);
    expect(copy.name, 'Ana');
    expect(copy.phone, '0917');
  });

  test('New contact map has no id so SQLite can auto increment it', () {
    const contact = Contact(name: 'Ben', phone: '0928');

    expect(contact.toMap().containsKey('id'), false);
  });
}
