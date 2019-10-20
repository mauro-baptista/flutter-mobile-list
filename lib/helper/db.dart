import 'package:firebase_database/firebase_database.dart';

class DB {
  final DatabaseReference _db = FirebaseDatabase().reference();
  String _table;

  DatabaseReference get reference {
    assert(table != null);

    return _db.child(_table);
  }

  DB table(String table) {
    _table = table;

    return this;
  }

  dynamic fetch(String id) async {
    DataSnapshot data = await reference.child(id).once();

    return data.value;
  }
}