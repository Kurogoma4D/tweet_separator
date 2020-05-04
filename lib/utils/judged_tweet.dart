import 'package:sqflite/sqflite.dart';
import 'package:tweet_separator/models/twitter_status.dart';

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

  Future<List<JudgedTweet>> getExistUsers(Iterable<int> existIds) async {
    final List<Map> judgedUsers =
        await db.query(tableName, where: 'id in (${existIds.join(', ')})');
    return judgedUsers
        .map((raw) => JudgedTweet.fromMap(raw as Map<String, dynamic>))
        .toList();
  }

  Future setJudgement(JudgedTweet judged) async {
    await db.rawInsert(
      '''insert or replace into $tableName(id, agreed, disagreed)
        values(?, ?, ?)''',
      <int>[judged.id, judged.agreed, judged.disagreed],
    );
  }

  Future<List<String>> getOrganizableUser() async {
    final List<Map> countedUsers =
        await db.query(tableName, where: 'disagreed > 0');
    final disagreedUsers = countedUsers
        .map((raw) => JudgedTweet.fromMap(raw as Map<String, dynamic>))
        .where((judged) =>
            judged.disagreed / (judged.agreed + judged.disagreed) > 0.6)
        .toList();
    return disagreedUsers.map((user) => user.id.toString()).toList();
  }

  Future close() async => db.close();
}
