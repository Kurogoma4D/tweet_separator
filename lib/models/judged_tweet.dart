import 'package:sqflite/sqflite.dart';

class JudgedTweet {
  JudgedTweet({
    this.id = 0,
    this.agreed = 0,
    this.disagreed = 0,
  });

  JudgedTweet.fromMap(Map<String, dynamic> map) {
    id = map['id'] as int;
    agreed = map['agreed'] as int;
    disagreed = map['disagreed'] as int;
  }

  int id;
  int agreed;
  int disagreed;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      id.toString(): id,
      agreed.toString(): agreed,
      disagreed.toString(): disagreed,
    };
  }
}

class JudgedStoreHelper {
  JudgedStoreHelper() {
    open();
  }

  Database db;
  String get tableName => 'JudgedTweet';

  Future open() async {
    final dbPath = await getDatabasesPath();
    db = await openDatabase(
      '${dbPath}judged_tweet.db',
      onCreate: (db, version) async {
        await db.execute('''create table $tableName (
          id integer primary key,
          agreed integer not null,
          disagreed integer not null
        )''');
      },
      version: 1,
    );
  }

  Future<List<JudgedTweet>> getExistUsers(String existIds) async {
    final List<Map> judgedUsers = await db
        .rawQuery('''select * from $tableName where id in ($existIds)''');
    return judgedUsers
        .map((raw) => JudgedTweet.fromMap(raw as Map<String, dynamic>))
        .toList();
  }

  Future close() async => db.close();
}
